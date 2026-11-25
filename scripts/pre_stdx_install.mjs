// scripts/pre_stdx_install.mjs —— 仅负责仓颉 stdx 二进制下载与解压（har 下载见 pre_har_install.mjs）
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { downloadVerified, removeTempFile, retryOnBusy, runCommand } from './pre_install_utils.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
// stdx_bin 位于 markdown 子目录，由 markdown/cjpm.toml 以 ./stdx_bin 相对路径引用
const PROJECT_ROOT = path.resolve(__dirname, '../markdown');

// ---------- stdx 配置 ----------
const STDX_VERSION = '1.1.3.1';
const STDX_BASE_URL = `https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v${STDX_VERSION}`;
const STDX_EXTRACT_PATH = path.join(PROJECT_ROOT, 'stdx_bin');
// DevEco 可能在上一次 ohpm install 结束前再触发一次，preInstall 钩子因而并发执行；
// 临时 zip 与暂存目录都带 pid，避免多个进程互相改写、误删同一个文件
const PID_SUFFIX = `.${process.pid}`;
// 先完整解压到进程私有的暂存目录，再整体改名为 stdx_bin：stdx_bin 一旦出现就一定是完整的
const STDX_STAGING_PATH = `${STDX_EXTRACT_PATH}${PID_SUFFIX}`;
// 下载 zip 的 SHA256 校验值，不一致即终止，防止被篡改的二进制进入构建环境
const STDX_ZIP_SHA256 = {
  aarch64: '21f452444d7f7106c2a7e376aa335a1e6d4308453ac1d7ad699f2fbf93ff5528',
  x64: '822be67189eaef7d856f2d3bde8fdb68b82bfc44b6a3a67a01a93b40e6fe90ff',
};
// aarch64 与 x64 全平台必需，无条件下载
const STDX_PACKAGES = [
  { arch: 'aarch64', dir: 'linux_ohos_aarch64_cjnative' },
  { arch: 'x64', dir: 'linux_ohos_x86_64_cjnative' },
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
function stdxReady(root = STDX_EXTRACT_PATH) {
  return STDX_PACKAGES
    .every((pkg) => {
      const staticStdx = path.join(root, pkg.dir, 'static', 'stdx');
      if (!fs.existsSync(staticStdx) || !fs.statSync(staticStdx).isDirectory()) {
        return false;
      }
      if (!REQUIRED_STDX_FILES.every((file) => fs.existsSync(path.join(staticStdx, file)))) {
        return false;
      }
      const dynamicStdx = path.join(root, pkg.dir, 'dynamic', 'stdx');
      return fs.existsSync(dynamicStdx) && fs.statSync(dynamicStdx).isDirectory();
    });
}

// 暂存目录仅本进程使用，成功（并发时让给先装好的实例）与失败都清理；清理失败只告警
function removeStagingDir() {
  if (!fs.existsSync(STDX_STAGING_PATH)) {
    return;
  }
  try {
    retryOnBusy(() => fs.rmSync(STDX_STAGING_PATH, { recursive: true, force: true }), `removing ${STDX_STAGING_PATH}`);
  } catch (error) {
    console.warn(`failed to remove staging dir ${STDX_STAGING_PATH}: ${error.message}, please delete it manually`);
  }
}

// ---------- 1. stdx：已完整则跳过，否则逐包下载到暂存目录，完整后改名落盘 ----------
if (stdxReady()) {
  console.log(`${STDX_EXTRACT_PATH} already exists and is complete, skipping.`);
} else {
  try {
    // 已存在但不完整的 stdx_bin（历史遗留或被改动）先清掉，保证最终落盘的一定是完整目录
    fs.rmSync(STDX_EXTRACT_PATH, { recursive: true, force: true });
    fs.mkdirSync(STDX_STAGING_PATH, { recursive: true });
    for (const pkg of STDX_PACKAGES) {
      const url = `${STDX_BASE_URL}/cangjie-stdx-ohos-${pkg.arch}-${STDX_VERSION}.zip`;
      // pid 放在扩展名之前：Expand-Archive 只接受 .zip 结尾的文件
      const tempPath = path.join(PROJECT_ROOT, `${path.basename(url, '.zip')}${PID_SUFFIX}.zip`);
      try {
        console.log(`Downloading ${pkg.arch} version...`);
        downloadVerified(url, tempPath, STDX_ZIP_SHA256[pkg.arch], `${pkg.arch} ZIP`);
        // 刚下载的 zip 可能被杀毒、索引等进程短暂占用，解压失败时重试
        retryOnBusy(() => extractZip(tempPath, STDX_STAGING_PATH), `extracting ${path.basename(url)}`);
      } finally {
        // 无论成功失败都清理临时压缩包；清理失败只告警，不覆盖真正的错误
        removeTempFile(tempPath);
      }
    }
    if (!stdxReady(STDX_STAGING_PATH)) {
      throw new Error('stdx extraction incomplete: static/stdx files or dynamic/stdx missing');
    }
    try {
      // 目录改名是原子操作，不会出现半成品
      fs.renameSync(STDX_STAGING_PATH, STDX_EXTRACT_PATH);
    } catch (error) {
      // 并发实例已先一步装好时改名会因目标已存在而失败，此时直接复用它
      if (!stdxReady()) {
        throw error;
      }
    }
    console.log('stdx downloaded and extracted successfully.');
  } catch (error) {
    console.error(`stdx install failed: ${error.message}`);
    removeStagingDir();
    process.exit(1);
  }
  removeStagingDir();
}

console.log('stdx pre-install finished.');
