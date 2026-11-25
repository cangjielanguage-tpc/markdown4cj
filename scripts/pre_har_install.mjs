// scripts/pre_har_install.mjs —— 仅负责 formula-ffi har 包下载（stdx 下载见 pre_stdx_install.mjs）
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { downloadVerified, removeTempFile, retryOnBusy, sha256 } from './pre_install_utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
// har 落盘到 markdown/har 目录，由 markdown/oh-package.json5 的 file:./har/formula.har 引用
const PROJECT_ROOT = path.resolve(__dirname, '../markdown');

// ---------- formula-ffi har 配置 ----------
const HAR_URL = 'https://gitcode.com/Cangjie-TPC/formula-ffi/releases/download/v2.0.0/formula_6.1.1-v2.0.0.har';
// 落盘统一命名 formula.har，与 markdown/oh-package.json5 的 file:./har/formula.har 引用保持一致
const HAR_PATH = path.join(PROJECT_ROOT, 'har', 'formula.har');
// 下载 har 的 SHA256 校验值（按 curl 实际落盘字节计算，gitcode 对该资产返回 gzip 传输体），防止损坏或被篡改的 har 进入构建
const HAR_SHA256 = '347e16261ca26c93fcac1b00502d936f78e6f3f1844c23d2e358506a429b7c2e';
// 先落临时文件，校验通过后再替换，避免下载中断在 har/ 目录残留损坏文件；
// DevEco 可能在上一次 ohpm install 结束前再触发一次，临时文件名带 pid，避免并发的两个进程互相改写、误删
const HAR_TEMP_PATH = `${HAR_PATH}.${process.pid}.tmp`;

// ---------- formula-ffi har：存在且 SHA256 一致则跳过，否则下载到临时文件校验后替换 ----------
if (fs.existsSync(HAR_PATH) && sha256(HAR_PATH) === HAR_SHA256) {
  console.log(`${HAR_PATH} already exists, skipping.`);
} else {
  fs.mkdirSync(path.dirname(HAR_PATH), { recursive: true });
  try {
    downloadVerified(HAR_URL, HAR_TEMP_PATH, HAR_SHA256, 'HAR');
    // 校验通过后再替换到最终路径，中断的下载不会残留损坏文件；刚下载的文件可能被短暂占用，改名失败时重试
    retryOnBusy(() => fs.renameSync(HAR_TEMP_PATH, HAR_PATH), 'moving har into place');
    console.log('formula har downloaded successfully.');
  } catch (error) {
    console.error(`har download failed: ${error.message}`);
    removeTempFile(HAR_TEMP_PATH);
    process.exit(1);
  }
}

console.log('har pre-install finished.');
