// scripts/pre_stdx_install.mjs
import { execFileSync } from 'child_process';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
// stdx_bin 位于 markdown 子目录，由 markdown/cjpm.toml 以 ./stdx_bin 相对路径引用
const PROJECT_ROOT = path.resolve(__dirname, '../markdown');

const ARM64_ZIP_URL = 'https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v1.1.3.1/cangjie-stdx-ohos-aarch64-1.1.3.1.zip';
const ARM64_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'cangjie-stdx-ohos-aarch64-1.1.3.1.zip');
const ARM64_ZIP_SHA256 = '21f452444d7f7106c2a7e376aa335a1e6d4308453ac1d7ad699f2fbf93ff5528';

const X64_ZIP_URL = 'https://gitcode.com/Cangjie/cangjie_stdx/releases/download/v1.1.3.1/cangjie-stdx-ohos-x64-1.1.3.1.zip';
const X64_ZIP_TEMP_PATH = path.join(PROJECT_ROOT, 'cangjie-stdx-ohos-x64-1.1.3.1.zip');
const X64_ZIP_SHA256 = '822be67189eaef7d856f2d3bde8fdb68b82bfc44b6a3a67a01a93b40e6fe90ff';

// 仅校验项目内的 stdx 库，不读取任何本地环境变量
const STDX_BIN_PATH = path.join(PROJECT_ROOT, 'stdx_bin');

// formula HAR 包（LaTeX 公式渲染库），供 markdown/oh-package.json5 以 file:./har/formula.har 引用
const FORMULA_HAR_URL = 'https://gitcode.com/Cangjie-TPC/formula-ffi/releases/download/v1.4.1/formula_6.1.1-v1.4.1.har';
const FORMULA_HAR_TEMP_PATH = path.join(PROJECT_ROOT, 'formula.har.tmp');
const FORMULA_HAR_SHA256 = '33bf6f922fa4ec9166accfc0d957b5a382d5f4c9166c8e281f4d69134bcd2382';
const FORMULA_HAR_PATH = path.join(PROJECT_ROOT, 'har', 'formula.har');

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
    'stdx.unittest.data.cjo'
];

// 校验单个架构的静态库是否完整：static/stdx 目录下清单内文件全部存在
function hasArchBinaries(basePath, archDir) {
    const staticStdxPath = path.join(basePath, archDir, 'static', 'stdx');
    if (!fs.existsSync(staticStdxPath) || !fs.statSync(staticStdxPath).isDirectory()) {
        return false;
    }
    return REQUIRED_STDX_FILES.every(file => fs.existsSync(path.join(staticStdxPath, file)));
}

// 额外校验 dynamic/stdx 存在：markdown/cjpm.toml 的 --dy-std 与 path-option 依赖该目录结构
function hasArchDynamicBinaries(basePath, archDir) {
    const dynamicStdxPath = path.join(basePath, archDir, 'dynamic', 'stdx');
    return fs.existsSync(dynamicStdxPath) && fs.statSync(dynamicStdxPath).isDirectory();
}

function hasStdxBinaries(basePath) {
    return hasArchBinaries(basePath, 'linux_ohos_aarch64_cjnative') &&
        hasArchBinaries(basePath, 'linux_ohos_x86_64_cjnative') &&
        hasArchDynamicBinaries(basePath, 'linux_ohos_aarch64_cjnative') &&
        hasArchDynamicBinaries(basePath, 'linux_ohos_x86_64_cjnative');
}

function sha256(filePath) {
    return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}

// 以参数数组方式调用外部命令（不经 shell 解析），路径中的空格或特殊字符不影响执行
function runCommand(command, args) {
    try {
        execFileSync(command, args, { stdio: 'inherit', cwd: PROJECT_ROOT });
    } catch (error) {
        if (error.code === 'ENOENT') {
            console.error(`Command "${command}" not found. Please install it and re-run.`);
        }
        throw error;
    }
}

function downloadAndExtract(label, zipUrl, tempPath, expectedSha256, extractPath) {
    console.log(`Downloading ${label} version...`);
    runCommand('curl', ['-L', '-o', tempPath, zipUrl]);

    if (fs.existsSync(tempPath)) {
        if (fs.statSync(tempPath).size === 0) {
            console.error(`${label} ZIP file is empty, download failed`);
            fs.unlinkSync(tempPath);
            process.exit(1);
        }
    } else {
        console.error(`${label} ZIP file not found`);
        process.exit(1);
    }

    // SHA256 校验，不一致则终止，防止被篡改的二进制进入构建环境
    const actualSha256 = sha256(tempPath);
    if (actualSha256 !== expectedSha256) {
        console.error(`${label} ZIP SHA256 mismatch: expected ${expectedSha256}, got ${actualSha256}`);
        fs.unlinkSync(tempPath);
        process.exit(1);
    }
    console.log(`${label} ZIP SHA256 verified.`);

    try {
        console.log(`Extracting ${label} version...`);
        if (process.platform === 'win32') {
            // PowerShell 单引号字面量中的单引号需成对转义
            const psQuote = value => `'${String(value).replace(/'/g, "''")}'`;
            runCommand('powershell', ['-NoProfile', '-Command',
                `Expand-Archive -LiteralPath ${psQuote(tempPath)} -DestinationPath ${psQuote(extractPath)} -Force`]);
        } else {
            runCommand('unzip', ['-o', tempPath, '-d', extractPath]);
        }
    } finally {
        if (fs.existsSync(tempPath)) {
            fs.unlinkSync(tempPath);
        }
    }
}

// 下载 formula HAR 并校验 SHA256，通过后替换到 har/formula.har
function ensureFormulaHar() {
    if (fs.existsSync(FORMULA_HAR_PATH) && sha256(FORMULA_HAR_PATH) === FORMULA_HAR_SHA256) {
        console.log(`formula HAR already exists at ${FORMULA_HAR_PATH}, skipping download.`);
        return;
    }
    console.log(`Downloading formula HAR to ${FORMULA_HAR_PATH}...`);
    try {
        runCommand('curl', ['-L', '-o', FORMULA_HAR_TEMP_PATH, FORMULA_HAR_URL]);
    } catch (error) {
        console.error(`formula HAR download failed: ${error.message}`);
        process.exit(1);
    }

    if (fs.existsSync(FORMULA_HAR_TEMP_PATH)) {
        if (fs.statSync(FORMULA_HAR_TEMP_PATH).size === 0) {
            console.error(`formula HAR file is empty, download failed`);
            fs.unlinkSync(FORMULA_HAR_TEMP_PATH);
            process.exit(1);
        }
    } else {
        console.error(`formula HAR file not found`);
        process.exit(1);
    }

    // SHA256 校验，不一致则终止，防止被篡改的二进制进入构建环境
    const actualSha256 = sha256(FORMULA_HAR_TEMP_PATH);
    if (actualSha256 !== FORMULA_HAR_SHA256) {
        console.error(`formula HAR SHA256 mismatch: expected ${FORMULA_HAR_SHA256}, got ${actualSha256}`);
        fs.unlinkSync(FORMULA_HAR_TEMP_PATH);
        process.exit(1);
    }
    console.log(`formula HAR SHA256 verified.`);

    // 先落临时文件，校验通过后再替换，避免下载中断在 har/ 目录残留损坏文件
    fs.mkdirSync(path.dirname(FORMULA_HAR_PATH), { recursive: true });
    fs.renameSync(FORMULA_HAR_TEMP_PATH, FORMULA_HAR_PATH);
    console.log(`formula HAR installed to ${FORMULA_HAR_PATH}`);
}

// 两套架构的静态库与 dynamic 库完整则跳过，否则下载
if (hasStdxBinaries(STDX_BIN_PATH)) {
    console.log(`stdx binaries already exist at ${STDX_BIN_PATH}, skipping download.`);
} else {
    console.log(`Downloading required files to ${STDX_BIN_PATH}...`);
    try {
        fs.mkdirSync(STDX_BIN_PATH, { recursive: true });

        downloadAndExtract('ARM64', ARM64_ZIP_URL, ARM64_ZIP_TEMP_PATH, ARM64_ZIP_SHA256, STDX_BIN_PATH);
        downloadAndExtract('X64', X64_ZIP_URL, X64_ZIP_TEMP_PATH, X64_ZIP_SHA256, STDX_BIN_PATH);

        console.log(`All files downloaded and extracted successfully to ${STDX_BIN_PATH}`);
    } catch (error) {
        console.error(`Download or extraction failed: ${error.message}`);
        if (fs.existsSync(ARM64_ZIP_TEMP_PATH)) {
            fs.unlinkSync(ARM64_ZIP_TEMP_PATH);
        }
        if (fs.existsSync(X64_ZIP_TEMP_PATH)) {
            fs.unlinkSync(X64_ZIP_TEMP_PATH);
        }
        process.exit(1);
    }
}

// 确保 formula HAR 就位（存在且 SHA256 匹配则跳过，否则重新下载）
ensureFormulaHar();
