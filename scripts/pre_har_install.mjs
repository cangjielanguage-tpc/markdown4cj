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

const OBS_BASE = 'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish';

// cangjie-plugin-6.1.1_compatibility 发布的 v2.0.0 产物清单，与下载内容 SHA256 绑定，
// 校验不一致即视为下载损坏或被篡改，不会进入构建
const ARTIFACTS = [
    {
        name: 'prism_hybrid.har',
        url: `${OBS_BASE}/prism4cj/prism4cj_hybrid_cangjie-plugin-6.1.1_compatibility/prism_hybrid_6.1.1-v2.0.0.har`,
        sha256: '1a6559313a536104c4126a5d4c6c6a0d21d180433343d5d15548f8aaae31e271'
    },
    {
        name: 'codeformat_hybrid.har',
        url: `${OBS_BASE}/codeformat4cj/codeformat_hybrid_cangjie-plugin-6.1.1_compatibility/codeformat_hybrid_6.1.1-v2.0.0.har`,
        sha256: '17a4bf07b5f6212c051876f1ad49d7753dbb1023399c04c00dad7e751204bac1'
    },
    {
        name: 'markdown_parser_hybrid.har',
        url: `${OBS_BASE}/markdown4cj/markdown_parser_hybrid_cangjie-plugin-6.1.1_compatibility/markdown_parser_hybrid_6.1.1-v2.0.0.har`,
        sha256: '244a96317ca7ab1abd077ee38ca058835518438d86f9157ecbbfe3d8d228a6d0'
    },
    {
        name: 'formula_hybrid.har',
        url: `${OBS_BASE}/formula-ffi/formula-ffi_hybrid_cangjie-plugin-6.1.1_compatibility/formula_hybrid_6.1.1-v2.0.0.har`,
        sha256: '0327936e6b00a2d3fab684bd9ee6e4b55556201d48e6fb1995c1b3573e508d83'
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
        execFileSync(command, args, { stdio: 'inherit', cwd: PROJECT_ROOT });
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
    runCommand('curl', ['-fL', '--retry', '3', '--retry-delay', '2', '-o', temp, artifact.url]);

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
