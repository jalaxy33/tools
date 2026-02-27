# Windows 配置 Claude Code

以下命令使用 `powershell` 运行。

## 修改系统设置

Win11 用户需要修改以下设置：

设置 > 系统 > 高级 > 开发者选项 > 启用开发人员模式

## 安装依赖

- 安装网络加速工具
  - 如 `Watt Toolkit`：[下载链接](https://steampp.net/)

    安装后打开软件，选择左边栏第二个 `网络加速` > 勾选全部平台 > 右上角点击 `一键加速`。

- 安装 Git：[官网](https://git-scm.com/install/windows)
  ```sh
  winget install Git.Git
  ```
- 安装nodejs：
  1.  安装fnm
      ```sh
      winget install Schniz.fnm
      ```
  2.  检查 powershell 的配置文件是否存在，如果没有就创建一下。配置文件有两个位置：
      - `C:\Users\你的用户名\Documents\PowerShell\profile.ps1`
      - `C:\Users\你的用户名\Documents\WindowsPowerShell\profile.ps1`

      中间没有的目录手动创建一下。

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

- 安装uv（python环境）：
  1. 安装

     ```sh
     winget install astral-sh.uv
     ```

  2. 重启终端，检查是否安装成功

     ```sh
     uv
     ```

  3. 添加配置文件，创建 `%APPDATA%\uv\uv.toml` （即 `C:\Users\你的用户名\AppData\Roaming\uv\uv.toml`）文件，中间没有的目录手动创建一下。
  4. 添加以下内容：

     ```toml
     [[index]]
     url = "https://mirrors.ustc.edu.cn/pypi/simple"
     default = true
     ```

- 下载安装 cc-switch：[windows安装文档](https://github.com/farion1231/cc-switch/blob/main/README_ZH.md#windows-用户)

  安装后，点击左上角齿轮⚙️图标，在 `窗口行为` 里启用 `跳过 Claude Code 初次安装确认`。

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
