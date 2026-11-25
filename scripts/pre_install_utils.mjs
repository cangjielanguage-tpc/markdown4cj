// scripts/pre_install_utils.mjs —— pre_har_install 共享下载与校验工具
import { execFileSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';

export function sha256(filePath) {
    return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}

// 以参数数组方式调用外部命令（不经 shell 解析），路径中的空格或特殊字符不影响执行
export function runCommand(command, args) {
    try {
        execFileSync(command, args, { stdio: 'inherit' });
    } catch (error) {
        if (error.code === 'ENOENT') {
            console.error(`Command "${command}" not found. Please install it and re-run.`);
        }
        throw error;
    }
}

export function assertDownloaded(file, url) {
    if (!fs.existsSync(file) || fs.statSync(file).size === 0) {
        throw new Error(`downloaded file missing or empty: ${url}`);
    }
}

// 刚下载的文件可能被杀毒软件、索引等进程短暂占用（EBUSY / EPERM），解压、改名、删除会失败。
// 按固定间隔重试，超过次数仍失败则抛出最后一次的错误；命令不存在（ENOENT）不重试。
export function retryOnBusy(operation, description, attempts = 10, intervalMs = 1000) {
    for (let attempt = 1; ; attempt++) {
        try {
            return operation();
        } catch (error) {
            if (attempt >= attempts || error.code === 'ENOENT') {
                throw error;
            }
            console.warn(`${description} failed, the file may be in use by another process, retrying ${attempt}/${attempts - 1} ...`);
            Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, intervalMs);
        }
    }
}

// 删除临时文件：被占用时重试，仍失败只告警，不覆盖真正的错误
export function removeTempFile(filePath) {
    if (!fs.existsSync(filePath)) {
        return;
    }
    try {
        retryOnBusy(() => fs.unlinkSync(filePath), `removing ${filePath}`);
    } catch (error) {
        console.warn(`failed to remove temp file ${filePath}: ${error.message}, please delete it manually`);
    }
}

// 下载到 filePath 并校验 SHA256，不一致即终止，防止损坏或被篡改的文件进入构建环境。
// 下载失败或校验失败时抛出异常，临时文件由调用方清理。
export function downloadVerified(url, filePath, expectedSha256, name) {
    runCommand('curl', ['-L', '--fail', '--retry', '3', '-o', filePath, url]);
    assertDownloaded(filePath, url);
    const actualSha256 = sha256(filePath);
    if (actualSha256 !== expectedSha256) {
        throw new Error(`${name} SHA256 mismatch: expected ${expectedSha256}, got ${actualSha256}`);
    }
    console.log(`${name} SHA256 verified.`);
}
