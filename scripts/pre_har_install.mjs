// scripts/pre_har_install.mjs
import { execFileSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '..');
// markdown_arkui/oh-package.json5 以 ./har/xxx.har 引用这 4 个预编译依赖
const HAR_DIR = path.join(PROJECT_ROOT, 'markdown_arkui', 'har');

// Cangjie-TPC 在 gitcode.com 发布的 hybrid 产物清单（prism 为 v2.0.1，其余为 v2.0.0），与下载内容 SHA256 绑定，
// 校验不一致即视为下载损坏或被篡改，不会进入构建
const ARTIFACTS = [
    {
        name: 'prism_hybrid.har',
        url: 'https://gitcode.com/Cangjie-TPC/prism4cj/releases/download/v2.0.1-hybrid/prism_hybrid_6.1.1-v2.0.1-hybrid.har',
        sha256: '50f9239926586727fc0052ca121aa760d6e995e75d68f72c0aa9b5a2a12cb6fe'
    },
    {
        name: 'codeformat_hybrid.har',
        url: 'https://gitcode.com/Cangjie-TPC/codeformat4cj/releases/download/v2.0.0-hybrid/codeformat_hybrid_6.1.1-v2.0.0-hybrid.har',
        sha256: '9904e858599e2e938548833863ada40cc03378882c15d1353ef25d20c07c79f4'
    },
    {
        name: 'markdown_parser_hybrid.har',
        url: 'https://gitcode.com/Cangjie-TPC/markdown4cj/releases/download/v2.0.0-markdown-parser-hybrid/markdown_parser_hybrid_6.1.1-v2.0.0-markdown-parser-hybrid.har',
        sha256: 'f013c0fe7646671a234e7a04d53294a1bda22c61b8e10540ce3f38264eb489f7'
    },
    {
        name: 'formula_hybrid.har',
        url: 'https://gitcode.com/Cangjie-TPC/formula-ffi/releases/download/v2.0.0-hybrid/formula_hybrid_6.1.1-v2.0.0-hybrid.har',
        sha256: 'c17e4ed40f84c00bbb55d3d0f74db1c983a09cba9494fe375249f7a25839a3d4'
    }
];

function sha256(filePath) {
    return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}

// 校验单个 HAR：存在、非空且 SHA256 与锁定值一致
function isValid(filePath, expectedSha256) {
    if (!fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) {
        return false;
    }
    if (fs.statSync(filePath).size === 0) {
        return false;
    }
    return sha256(filePath) === expectedSha256;
}

// 以参数数组方式调用外部命令（不经 shell 解析），路径中的空格或特殊字符不影响执行
function runCommand(command, args) {
    try {
        execFileSync(command, args, { stdio: 'inherit' });
    } catch (error) {
        if (error.code === 'ENOENT') {
            console.error(`Command "${command}" not found. Please install it and re-run.`);
        }
        throw error;
    }
}

function downloadArtifact(artifact) {
    const target = path.join(HAR_DIR, artifact.name);
    const temp = `${target}.download`;

    console.log(`Downloading ${artifact.name} ...`);
    runCommand('curl', ['-L', '--fail', '--retry', '3', '-o', temp, artifact.url]);

    if (!fs.existsSync(temp) || fs.statSync(temp).size === 0) {
        throw new Error(`${artifact.name} download is empty`);
    }

    // SHA256 校验，不一致则终止，防止损坏或被篡改的 HAR 进入构建
    const actual = sha256(temp);
    if (actual !== artifact.sha256) {
        throw new Error(`${artifact.name} SHA256 mismatch: expected ${artifact.sha256}, got ${actual}`);
    }

    // 校验通过后再落位，避免中断的下载残留半截文件
    if (fs.existsSync(target)) {
        fs.unlinkSync(target);
    }
    fs.renameSync(temp, target);
    console.log(`${artifact.name} verified.`);
}

// 4 个 HAR 全部存在且校验通过则跳过，否则逐个补齐缺失或损坏的文件
const pending = ARTIFACTS.filter(artifact => !isValid(path.join(HAR_DIR, artifact.name), artifact.sha256));

if (pending.length === 0) {
    console.log(`HAR dependencies already exist at ${HAR_DIR}, skipping download.`);
} else {
    console.log(`Downloading required HAR files to ${HAR_DIR}...`);
    try {
        fs.mkdirSync(HAR_DIR, { recursive: true });
        for (const artifact of pending) {
            downloadArtifact(artifact);
        }
        // 下载后整体复查：4 个 HAR 均存在且 SHA256 一致，与 stdx 脚本的解压后完整性复查对齐
        if (!ARTIFACTS.every((artifact) => isValid(path.join(HAR_DIR, artifact.name), artifact.sha256))) {
            throw new Error('HAR verification incomplete after download');
        }
        console.log(`All HAR files downloaded and verified: ${HAR_DIR}`);
    } catch (error) {
        console.error(`Download or verification failed: ${error.message}`);
        for (const artifact of ARTIFACTS) {
            const temp = path.join(HAR_DIR, `${artifact.name}.download`);
            if (fs.existsSync(temp)) {
                fs.unlinkSync(temp);
            }
        }
        process.exit(1);
    }
}
