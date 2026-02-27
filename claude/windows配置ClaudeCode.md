# Windows 安装 Claude Code

以下命令使用 `powershell` 运行。

## 安装依赖

- 安装 Watt Toolkit（网络环境）：https://steampp.net/
- 安装 Git：https://git-scm.com/install/windows
  ```sh
  winget install Git.Git
  ```
- 安装nodejs：
  1.  安装fnm
      ```sh
      winget install Schniz.fnm
      ```
  2.  检查 powershell 的配置文件是否存在，如果没有就创建一下。配置文件有两个位置：
      - `~/Documents/PowerShell/profile.ps1`
      - `~/Documents/WindowsPowerShell/profile.ps1`

  3.  在配置文件里写入：

      ```ps1
      # 设置fnm镜像
      $env:FNM_NODE_DIST_MIRROR = "https://npmmirror.com/mirrors/node/"

      # 激活fnm
      fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
      ```

  4.  安装nodejs
      ```sh
      fnm install --latest
      ```
  5.  重启终端，检查npm命令
      ```sh
      npm
      ```
- 安装 cc-switch：https://github.com/farion1231/cc-switch/blob/main/README_ZH.md#windows-用户


## 安装 claude-code

- npm 安装

  ```
  npm install -g @anthropic-ai/claude-code
  ```

- 运行一次claude生成配置文件
  ```
  claude
  ```

之后的流程按[配置指南](./ClaudeCode配置指南.md)里的来。


