// scripts/pre_install_utils.mjs —— pre_har_install 共享工具
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
