// scripts/pre_stdx_install.mjs
import { execFileSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '..');

// ---------- stdx 配置 ----------
const STDX_VERSION = '1.1.3.1';
const STDX_BASE_URL = `https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v${STDX_VERSION}`;
const STDX_EXTRACT_PATH = path.join(PROJECT_ROOT, 'stdx_bin');
// aarch64 全平台必需；x64 仅 Windows 本机需要
const STDX_PACKAGES = [
  { arch: 'aarch64', dir: 'linux_ohos_aarch64_cjnative', required: true },
  { arch: 'x64', dir: 'linux_ohos_x86_64_cjnative', required: process.platform === 'win32' },
];

// ---------- formula-ffi har 配置 ----------
const HAR_URL = 'https://gitcode.com/Cangjie-TPC/formula-ffi/releases/download/v2.0.0/formula_6.1.1-v2.0.0.har';
// 落盘统一命名 formula.har，与 markdown_hybrid/oh-package.json5 的 file:./har/formula.har 引用保持一致
const HAR_PATH = path.join(PROJECT_ROOT, 'markdown_hybrid', 'har', 'formula.har');

function download(url, dest) {
  console.log(`Downloading ${path.basename(dest)} ...`);
  execFileSync('curl', ['-L', '--fail', '--retry', '3', '-o', dest, url], { stdio: 'inherit' });
}

function assertDownloaded(file, url) {
  if (!fs.existsSync(file) || fs.statSync(file).size === 0) {
    throw new Error(`downloaded file missing or empty: ${url}`);
  }
}

function extractZip(zip, destDir) {
  console.log(`Extracting ${path.basename(zip)} ...`);
  if (process.platform === 'win32') {
    // PowerShell 单引号成对转义，防路径特殊字符破坏命令
    const quote = (p) => `'${p.replace(/'/g, "''")}'`;
    execFileSync('powershell', ['-NoProfile', '-Command', `Expand-Archive -LiteralPath ${quote(zip)} -DestinationPath ${quote(destDir)} -Force`], { stdio: 'inherit' });
  } else {
    execFileSync('unzip', ['-o', zip, '-d', destDir], { stdio: 'inherit' });
  }
}

// stdx 解压完整性：各必需架构的 dynamic/stdx 目录必须存在（防解压中断残留残缺目录）
function stdxReady() {
  return STDX_PACKAGES
    .filter((pkg) => pkg.required)
    .every((pkg) => fs.existsSync(path.join(STDX_EXTRACT_PATH, pkg.dir, 'dynamic', 'stdx')));
}

// ---------- 1. stdx：已完整则跳过，否则逐包下载解压 ----------
if (stdxReady()) {
  console.log(`${STDX_EXTRACT_PATH} already exists and is complete, skipping.`);
} else {
  fs.mkdirSync(STDX_EXTRACT_PATH, { recursive: true });
  try {
    for (const pkg of STDX_PACKAGES) {
      if (!pkg.required) {
        continue;
      }
      const url = `${STDX_BASE_URL}/cangjie-stdx-ohos-${pkg.arch}-${STDX_VERSION}.zip`;
      const tempPath = path.join(PROJECT_ROOT, path.basename(url));
      try {
        download(url, tempPath);
        assertDownloaded(tempPath, url);
        extractZip(tempPath, STDX_EXTRACT_PATH);
      } finally {
        // 无论成功失败都清理临时压缩包
        if (fs.existsSync(tempPath)) {
          fs.unlinkSync(tempPath);
        }
      }
    }
    if (!stdxReady()) {
      throw new Error('stdx extraction incomplete: dynamic/stdx missing');
    }
    console.log('stdx downloaded and extracted successfully.');
  } catch (error) {
    console.error(`stdx install failed: ${error.message}`);
    process.exit(1);
  }
}

// ---------- 2. formula-ffi har：已存在则跳过 ----------
if (fs.existsSync(HAR_PATH) && fs.statSync(HAR_PATH).size > 0) {
  console.log(`${HAR_PATH} already exists, skipping.`);
} else {
  fs.mkdirSync(path.dirname(HAR_PATH), { recursive: true });
  try {
    download(HAR_URL, HAR_PATH);
    assertDownloaded(HAR_PATH, HAR_URL);
    console.log('formula har downloaded successfully.');
  } catch (error) {
    console.error(`har download failed: ${error.message}`);
    if (fs.existsSync(HAR_PATH)) {
      fs.unlinkSync(HAR_PATH);
    }
    process.exit(1);
  }
}

console.log('Pre-install finished.');
