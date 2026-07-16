export {}

declare global {
  interface GlobalThis {
    fileList: string
    rawFilePath: string
    markdownContent: string
    safeTop: string
    navigate: (page: string) => void
    routerBack: (param: string) => void
    loadContent: (filePath: string) => void
  }
}
