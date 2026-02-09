## 常用插件

### 通用

【必要】

- 简中语言支持：`Chinese (Simplified) (简体中文) Language Pack`
- 管理依赖版本：`Dependi`
- 行内显示错误信息：`Error Lens`
- 显示文件大小：`file-size`
- 高亮当前缩进范围：`Indenticator`
- 带颜色高亮的命令行输出：`Output Colorizer`
- 自动填充路径：`Path Intellisense`
- TODO/FIXME 高亮：`TODO Highlight`
- 文件操作：`File Utils`
- tab跳出括号：`TabOut`

【可选】

- 代码截图：`CodeSnap-plus`
- 在 vscode 内使用 Lazygit：`Lazygit for VSCode`
- 快速搜索：`FindItFaster`（需要提前安装软件 `fzf`, `rg`, `bat`）
- 远程连接：`Remote Development` 或 `Remote - SSH`
- 自动拉取 github wiki：`Git WiKi Sync`
- AI 助手：`Github Copilot` 或 `Lingma`
  - 需要一点额外配置的： `Claude Code for VS Code`（配置方法请看 [ClaudeCode 配置指南](../claude/ClaudeCode配置指南.md)）

### 代码阅读

- 项目文件依赖关系：`AtomicViz`
- 代码阅读记录：`CodeTour`
- 导航记录：`Navigation History`
- 比较代码片段差异：`Partial Diff`

### Python

- python 语言支持：`python`
- 代码格式化：`Ruff`
- jupyter 支持：`Jupyter`

【可选】

- 性能更好的 LSP：`ty`（需要用 `uvx ty` 安装）

### Rust

- rust 语言支持：`rust-analyzer`
- Debugger：`CodeLLDB`

### 前端

- 运行 Local Server：`Live Preview`

### C/C++

- 语言支持：`C/C++` 或 `clangd`
- 编译工具：`CMake Tools` 或 `xmake`
- CMake格式化：`CMake Language Support`


### 特定文件格式

【必要】

- 常用文件格式化：`Prettier`
- toml 语法高亮：`Less TOML` 或 `Even Better TOML`
- 更多 Markdown 功能：`Markdown All in One`
- 查看 Excel 和 CSV：`Excel Viewer`
- CSV 彩色显示：`Rainbow CSV`

【可选】

- 十六进制编辑器：`Hex Editor`
- Markdown to PDF：`Markdown PDF`
- pdf 阅读器：`vscode-pdf`
- docx 阅读器：`Docx/ODT Viewer`
- 查看 PBM 图像：`PBM/PPM/PGM Viewer`
- powershell 脚本 (.ps1) 语法提示：`PowerShell`
- nushell 角标 (.nu) 语法提示：`vscode-nushell-lang`

### 主题外观

- 文件图标：`Icons` 或 `vscode-icons` 或 `Catppuccin Icons for VSCode`
- 主题：`Gruvbox Theme` 或 `Pale Fire` 或 `Catppuccin for VSCode`

---

## 自定义设置

### 终端字体

Jetbrains Mono：

```json
{
  "editor.fontFamily": "JetBrainsMono Nerd Font Mono"
}
```

如果是 [Maple Mono](https://github.com/subframe7536/maple-font)，改为：

```json
{
  "editor.fontFamily": "Maple Mono NF CN"
}
```

### 内联提示

```json
{
  "editor.inlayHints.enabled": "offUnlessPressed",
  "editor.inlineCompletionsAccessibilityVerbose": true
}
```

### 换行策略

```json
{
  "editor.wrappingStrategy": "advanced",
}
```

### 路径转换

```json
{
  "explorer.copyPathSeparator": "/",
  "explorer.copyRelativePathSeparator": "/"
}
```

### Rust

```json
{
  "rust-analyzer.check.command": "clippy",
  "rust-analyzer.cargo.buildScripts.enable": false,
  "rust-analyzer.checkOnSave": false,
  "rust-analyzer.cargo.buildScripts.rebuildOnSave": false,
  "rust-analyzer.completion.callable.snippets": "none"
  "rust-analyzer.completion.autoimport.enable": false,
}
```

### python

```json
{
  "python.analysis.inlayHints.functionReturnTypes": true,
  "python.terminal.shellIntegration.enabled": true,
  "python.analysis.enablePerfTelemetry": true,
  "python.analysis.importFormat": "relative",
  "python.analysis.inlayHints.pytestParameters": true,
  "python.analysis.inlayHints.variableTypes": true,
  "python.analysis.supportDocstringTemplate": true,
  "python.analysis.typeEvaluation.strictDictionaryInference": true,
  "python.analysis.typeEvaluation.strictListInference": true,
  "python.analysis.typeEvaluation.strictSetInference": true
}
```

如果用 ty

```json
{
  "python.languageServer": "None"
}
```

### C++

```json
{
  "cmake.automaticReconfigure": false,
  "cmake.configureOnEdit": false,
  "cmake.configureOnOpen": false
}
```

## 快捷键

- 格式化文档 `editor.action.formatDocument`：`Shift+Alt+F`
- 在终端中运行 Python 文件 `Run Python File in Terminal`：`Crtl+Shift+Alt+Enter`
- 运行 rust 程序：`rust-analyzer: Run`：`Crtl+Alt+Enter`

## 遇到过的问题

### copilot 没有 claude 模型

需要挂代理，并且在 vscode 设置中设置：

```json
{
  "http.proxy": "http://127.0.0.1:7890",
  "http.proxyStrictSSL": false
}
```
