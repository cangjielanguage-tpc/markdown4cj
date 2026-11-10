// scripts/pre_stdx_install.mjs —— 下载 @cangjie-tpc/markdown 的预编译 HAR 依赖（共享工具见 pre_install_utils.mjs）
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { downloadVerified, removeTempFile, retryOnBusy, sha256 } from './pre_install_utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '..');
// markdown_hybrid/oh-package.json5 以 ./har/markdown.har 引用这个预编译依赖
const HAR_DIR = path.join(PROJECT_ROOT, 'markdown_hybrid', 'har');

// Cangjie-TPC 在 gitcode.com 发布的 v2.0.0 产物清单，与下载内容 SHA256 绑定，
// 校验不一致即视为下载损坏或被篡改，不会进入构建
const ARTIFACTS = [
    {
        name: 'markdown.har',
        url: 'https://gitcode.com/Cangjie-TPC/markdown4cj/releases/download/v2.0.0/markdown_6.1.1-v2.0.0.har',
        sha256: '4cc1ca07e4565ea6191a7178934ffad625fa1c1d5d521bf32b460bb9d96054fa'
    }
];

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

// 下载到临时文件，SHA256 校验通过后再替换到最终路径；中断的下载不会残留损坏文件。
// DevEco 可能在上一次 ohpm install 结束前再触发一次，preInstall 钩子因而并发执行，
// 临时文件名带 pid，避免并发的两个进程互相改写、误删
function downloadArtifact(artifact) {
    const target = path.join(HAR_DIR, artifact.name);
    const temp = `${target}.${process.pid}.tmp`;

    console.log(`Downloading ${artifact.name} ...`);
    downloadVerified(artifact.url, temp, artifact.sha256, artifact.name);
    // 刚下载的文件可能被杀毒软件、索引等进程短暂占用，改名失败时重试
    retryOnBusy(() => fs.renameSync(temp, target), `moving ${artifact.name} into place`);
}

// 所有 HAR 已存在且校验通过则跳过，否则逐个补齐缺失或损坏的文件
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
        // 下载后整体复查：所有 HAR 均存在且 SHA256 一致
        if (!ARTIFACTS.every((artifact) => isValid(path.join(HAR_DIR, artifact.name), artifact.sha256))) {
            throw new Error('HAR verification incomplete after download');
        }
        console.log(`All HAR files downloaded and verified: ${HAR_DIR}`);
    } catch (error) {
        console.error(`Download or verification failed: ${error.message}`);
        // 只清理本进程创建的临时文件，并发的其他实例互不干扰；清理失败只告警，不覆盖真正的错误
        for (const artifact of ARTIFACTS) {
            removeTempFile(path.join(HAR_DIR, `${artifact.name}.${process.pid}.tmp`));
        }
        process.exit(1);
    }
}
