// scripts/pre_har_install.mjs —— 仅负责 formula-ffi har 包下载
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { assertDownloaded, runCommand, sha256 } from './pre_install_utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
// har 落盘到 markdown/har 目录，由 markdown/oh-package.json5 的 file:./har/formula.har 引用
const PROJECT_ROOT = path.resolve(__dirname, '../markdown');

// ---------- formula-ffi har 配置 ----------
const HAR_URL = 'https://gitcode.com/Cangjie-TPC/formula-ffi/releases/download/v2.0.0/formula_6.1.1-v2.0.0.har';
// 落盘统一命名 formula.har，与 markdown/oh-package.json5 的 file:./har/formula.har 引用保持一致
const HAR_PATH = path.join(PROJECT_ROOT, 'har', 'formula.har');
// 下载 har 的 SHA256 校验值，与 markdown4cj 仓库的锁定值保持一致，防止损坏或被篡改的 har 进入构建
const HAR_SHA256 = '347e16261ca26c93fcac1b00502d936f78e6f3f1844c23d2e358506a429b7c2e';
// 先落临时文件，校验通过后再替换，避免下载中断在 har/ 目录残留损坏文件
const HAR_TEMP_PATH = path.join(PROJECT_ROOT, 'formula.har.tmp');

// ---------- formula-ffi har：存在且 SHA256 一致则跳过，否则下载到临时文件校验后替换 ----------
if (fs.existsSync(HAR_PATH) && sha256(HAR_PATH) === HAR_SHA256) {
  console.log(`${HAR_PATH} already exists, skipping.`);
} else {
  fs.mkdirSync(path.dirname(HAR_PATH), { recursive: true });
  try {
    runCommand('curl', ['-L', '--fail', '--retry', '3', '-o', HAR_TEMP_PATH, HAR_URL]);
    assertDownloaded(HAR_TEMP_PATH, HAR_URL);
    const actualSha256 = sha256(HAR_TEMP_PATH);
    if (actualSha256 !== HAR_SHA256) {
      throw new Error(`HAR SHA256 mismatch: expected ${HAR_SHA256}, got ${actualSha256}`);
    }
    console.log('formula har SHA256 verified.');
    // 校验通过后再替换到最终路径，中断的下载不会残留损坏文件
    fs.renameSync(HAR_TEMP_PATH, HAR_PATH);
    console.log('formula har downloaded successfully.');
  } catch (error) {
    console.error(`har download failed: ${error.message}`);
    if (fs.existsSync(HAR_TEMP_PATH)) {
      fs.unlinkSync(HAR_TEMP_PATH);
    }
    process.exit(1);
  }
}

console.log('har pre-install finished.');
