import { harTasks } from '@ohos/hvigor-ohos-plugin';

import fs from 'fs';
import path from 'path';

export default {
  system: harTasks, /* Built-in plugin of Hvigor. It cannot be modified. */
  plugins: [renameHarTask()]       /* Custom plugin to extend the functionality of Hvigor. */
}

export function renameHarTask(str?: string) {
  return {
    pluginId: 'RenameHarTaskID',
    apply(pluginContext) {
      pluginContext.registerTask({
        // Write custom tasks
        name: 'renameHarTask',
        run: (taskContext) => {
          // Read oh-package.json5 and parse the version
          const packageFile = path.join(taskContext.modulePath, 'oh-package.json5');
          let fileContent = fs.readFileSync(packageFile, 'utf8');
          const content: OhPackage = JSON.parse(fileContent);
          const version = content.version;
          const sourceFile = path.join(taskContext.modulePath, 'build/default/outputs/default', `${taskContext.moduleName}.har`);
          const targetPath = path.join(taskContext.modulePath, 'build/default/outputs/target');
          const targetFile = path.join(targetPath, `${taskContext.moduleName}-${version}.har`);

          // Create Directory
          fs.mkdir(targetPath, { recursive: true }, (err) => {
            if (err) {
              throw err;
            }
            // Move and modify product file names
            fs.rename(sourceFile, targetFile, (err) => {
            });
          });
        },
        // Confirm custom task insertion position
        dependencies: ['default@PackageHar'],
        postDependencies: ['assembleHar']
      })
    }
  }
}
