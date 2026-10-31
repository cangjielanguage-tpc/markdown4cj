// scripts/pre_stdx_install.mjs
import { execFileSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = path.resolve(__dirname, '..');

// ---------- stdx 配置 ----------
const STDX_VERSION = '1.1.3.1';
const STDX_BASE_URL = `https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v${STDX_VERSION}`;
const STDX_EXTRACT_PATH = path.join(PROJECT_ROOT, 'stdx_bin');
// 下载 zip 的 SHA256 校验值，不一致即终止，防止被篡改的二进制进入构建环境
const STDX_ZIP_SHA256 = {
  aarch64: '21f452444d7f7106c2a7e376aa335a1e6d4308453ac1d7ad699f2fbf93ff5528',
  x64: '822be67189eaef7d856f2d3bde8fdb68b82bfc44b6a3a67a01a93b40e6fe90ff',
};
// aarch64 全平台必需；x64 仅 Windows 本机需要
const STDX_PACKAGES = [
  { arch: 'aarch64', dir: 'linux_ohos_aarch64_cjnative', required: true },
  { arch: 'x64', dir: 'linux_ohos_x86_64_cjnative', required: process.platform === 'win32' },
];

// cangjie-stdx-ohos v1.1.3.1 各架构 static/stdx 的完整文件清单，与下载 zip 的 SHA256 绑定，
// 用于检测解压中断导致的目录残缺（缺文件时视为未就绪，重新触发下载）
const REQUIRED_STDX_FILES = [
  'lib-macro_stdx.actors.macros.so',
  'libboundscheck-static.a',
  'libcangjie-dynamicLoader-opensslFFI.a',
  'libstdx.a',
  'libstdx.actors.a',
  'libstdx.actors.bc',
  'libstdx.actors.macros.bc',
  'libstdx.aspectCJ.a',
  'libstdx.aspectCJ.bc',
  'libstdx.bc',
  'libstdx.compress.a',
  'libstdx.compress.bc',
  'libstdx.compress.tar.a',
  'libstdx.compress.tar.bc',
  'libstdx.compress.tarFFI.a',
  'libstdx.compress.zlib.a',
  'libstdx.compress.zlib.bc',
  'libstdx.compress.zlibFFI.a',
  'libstdx.crypto.a',
  'libstdx.crypto.bc',
  'libstdx.crypto.common.a',
  'libstdx.crypto.common.bc',
  'libstdx.crypto.crypto.a',
  'libstdx.crypto.crypto.bc',
  'libstdx.crypto.digest.a',
  'libstdx.crypto.digest.bc',
  'libstdx.crypto.keys.a',
  'libstdx.crypto.keys.bc',
  'libstdx.crypto.keysFFI.a',
  'libstdx.crypto.kit.a',
  'libstdx.crypto.kit.bc',
  'libstdx.crypto.x509.a',
  'libstdx.crypto.x509.bc',
  'libstdx.crypto.x509FFI.a',
  'libstdx.effect.a',
  'libstdx.effect.bc',
  'libstdx.encoding.a',
  'libstdx.encoding.base64.a',
  'libstdx.encoding.base64.bc',
  'libstdx.encoding.bc',
  'libstdx.encoding.hex.a',
  'libstdx.encoding.hex.bc',
  'libstdx.encoding.json.a',
  'libstdx.encoding.json.bc',
  'libstdx.encoding.json.stream.a',
  'libstdx.encoding.json.stream.bc',
  'libstdx.encoding.json.streamFFI.a',
  'libstdx.encoding.jsonFFI.a',
  'libstdx.encoding.url.a',
  'libstdx.encoding.url.bc',
  'libstdx.fuzz.a',
  'libstdx.fuzz.bc',
  'libstdx.fuzz.fuzz.a',
  'libstdx.fuzz.fuzz.bc',
  'libstdx.fuzz.fuzzFFI.a',
  'libstdx.log.a',
  'libstdx.log.bc',
  'libstdx.logger.a',
  'libstdx.logger.bc',
  'libstdx.net.a',
  'libstdx.net.bc',
  'libstdx.net.http.a',
  'libstdx.net.http.bc',
  'libstdx.net.tls.a',
  'libstdx.net.tls.bc',
  'libstdx.net.tls.common.a',
  'libstdx.net.tls.common.bc',
  'libstdx.net.tlsFFI.a',
  'libstdx.serialization.a',
  'libstdx.serialization.bc',
  'libstdx.serialization.serialization.a',
  'libstdx.serialization.serialization.bc',
  'libstdx.string_intern.a',
  'libstdx.string_intern.bc',
  'libstdx.unittest.a',
  'libstdx.unittest.bc',
  'libstdx.unittest.data.a',
  'libstdx.unittest.data.bc',
  'stdx.actors.cjo',
  'stdx.actors.macros.cjo',
  'stdx.aspectCJ.cjo',
  'stdx.cjo',
  'stdx.compress.cjo',
  'stdx.compress.tar.cjo',
  'stdx.compress.zlib.cjo',
  'stdx.crypto.cjo',
  'stdx.crypto.common.cjo',
  'stdx.crypto.crypto.cjo',
  'stdx.crypto.digest.cjo',
  'stdx.crypto.keys.cjo',
  'stdx.crypto.kit.cjo',
  'stdx.crypto.x509.cjo',
  'stdx.effect.cjo',
  'stdx.encoding.base64.cjo',
  'stdx.encoding.cjo',
  'stdx.encoding.hex.cjo',
  'stdx.encoding.json.cjo',
  'stdx.encoding.json.stream.cjo',
  'stdx.encoding.url.cjo',
  'stdx.fuzz.cjo',
  'stdx.fuzz.fuzz.cjo',
  'stdx.log.cjo',
  'stdx.logger.cjo',
  'stdx.net.cjo',
  'stdx.net.http.cjo',
  'stdx.net.tls.cjo',
  'stdx.net.tls.common.cjo',
  'stdx.serialization.cjo',
  'stdx.serialization.serialization.cjo',
  'stdx.string_intern.cjo',
  'stdx.unittest.cjo',
  'stdx.unittest.data.cjo',
];

// ---------- formula-ffi har 配置 ----------
const HAR_URL = 'https://gitcode.com/Cangjie-TPC/formula-ffi/releases/download/v2.0.0/formula_6.1.1-v2.0.0.har';
// 落盘统一命名 formula.har，与 markdown_hybrid/oh-package.json5 的 file:./har/formula.har 引用保持一致
const HAR_PATH = path.join(PROJECT_ROOT, 'markdown_hybrid', 'har', 'formula.har');

function sha256(filePath) {
  return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
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

function assertDownloaded(file, url) {
  if (!fs.existsSync(file) || fs.statSync(file).size === 0) {
    throw new Error(`downloaded file missing or empty: ${url}`);
  }
}

function extractZip(zip, destDir) {
  console.log(`Extracting ${path.basename(zip)} ...`);
  if (process.platform === 'win32') {
    // PowerShell 单引号字面量中的单引号需成对转义，防路径特殊字符破坏命令
    const psQuote = (value) => `'${String(value).replace(/'/g, "''")}'`;
    runCommand('powershell', ['-NoProfile', '-Command', `Expand-Archive -LiteralPath ${psQuote(zip)} -DestinationPath ${psQuote(destDir)} -Force`]);
  } else {
    runCommand('unzip', ['-o', zip, '-d', destDir]);
  }
}

// stdx 解压完整性：各必需架构的 static/stdx 清单文件与 dynamic/stdx 目录必须齐全
// （cjpm.toml 的 path-option 引用 dynamic/stdx，static 库用于链接）
function stdxReady() {
  return STDX_PACKAGES
    .filter((pkg) => pkg.required)
    .every((pkg) => {
      const staticStdx = path.join(STDX_EXTRACT_PATH, pkg.dir, 'static', 'stdx');
      if (!fs.existsSync(staticStdx) || !fs.statSync(staticStdx).isDirectory()) {
        return false;
      }
      if (!REQUIRED_STDX_FILES.every((file) => fs.existsSync(path.join(staticStdx, file)))) {
        return false;
      }
      const dynamicStdx = path.join(STDX_EXTRACT_PATH, pkg.dir, 'dynamic', 'stdx');
      return fs.existsSync(dynamicStdx) && fs.statSync(dynamicStdx).isDirectory();
    });
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
        console.log(`Downloading ${pkg.arch} version...`);
        runCommand('curl', ['-L', '--fail', '--retry', '3', '-o', tempPath, url]);
        assertDownloaded(tempPath, url);
        const actualSha256 = sha256(tempPath);
        if (actualSha256 !== STDX_ZIP_SHA256[pkg.arch]) {
          throw new Error(`ZIP SHA256 mismatch: expected ${STDX_ZIP_SHA256[pkg.arch]}, got ${actualSha256}`);
        }
        console.log(`${pkg.arch} ZIP SHA256 verified.`);
        extractZip(tempPath, STDX_EXTRACT_PATH);
      } finally {
        // 无论成功失败都清理临时压缩包
        if (fs.existsSync(tempPath)) {
          fs.unlinkSync(tempPath);
        }
      }
    }
    if (!stdxReady()) {
      throw new Error('stdx extraction incomplete: static/stdx files or dynamic/stdx missing');
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
    runCommand('curl', ['-L', '--fail', '--retry', '3', '-o', HAR_PATH, HAR_URL]);
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
