# Windows软件推荐

## 初次进入系统时

必装：

- [scoop](https://github.com/ScoopInstaller/Scoop#installation)：命令行软件管理工具，国内推荐按照 [scoop-proxy-cn](https://github.com/lzwme/scoop-proxy-cn) 的方案安装。
- [clash-party](https://clashparty.org/)：代理工具。
- [Bulk-Crap-Uninstaller](https://www.bcuninstaller.com/)：软件卸载工具，比 Geek-Uninstaller 好用。

一次性工具

- [HEU_KMS_Activator](https://github.com/zbezj/HEU_KMS_Activator)：Windows和Office激活工具。
- [office-tool-plus](https://otp.landian.vip/zh-cn/)：下载指定版本的 Office 套件。

可选：

- 好用的浏览器：不想用自带的 Edge 的话，目前推荐 [Brave](https://brave.com/zh/) 或 [Zen-Browser](https://zen-browser.app/)，想要简单的可以试试 [Helium](https://helium.computer/)。
- [火绒](https://www.huorong.cn/)：安静的杀毒软件，安装后会自动屏蔽Windows防火墙。

设置：

- 开启 `sudo` 功能：
  - win11自带：设置 > 系统 > 高级 > 启用sudo > 配置sudo运行应用程序为「内联」
  - 或者额外装一个 `scoop install sudo`

## 命令行工具

除了powershell，基本上都推荐用 `scoop` 安装。

- [powershell7](https://learn.microsoft.com/zh-cn/powershell/scripting/install/install-powershell-on-windows)：推荐用 winget 安装

  ```sh
  winget install --id Microsoft.PowerShell
  ```

- [7zip](https://www.7-zip.org/)：加解压软件
- [git](https://git-scm.com/)：版本控制工具
- [scoop-search](https://github.com/tokiedokie/scoop-search)：速度更快的 `scoop search` 命令。
- [starship](https://starship.rs/)：终端美化
- [zoxide](https://github.com/ajeetdsouza/zoxide)：带记忆功能的 `cd` 命令
- [eza](https://github.com/eza-community/eza)：更现代的 `ls` 命令
- [yazi](https://yazi-rs.github.io/docs/installation/)：终端文件管理器。
- 一款 NerdFont 终端字体：推荐 [`Mapple-Mono-NF-CN`](https://github.com/subframe7536/maple-font) 或 [`JetBrainsMono-NF-Mono`](https://www.jetbrains.com/lp/mono/)

我的 powershell 配置文件：[profile.ps1](../powershell/profile.ps1)

## 日常用

- [vscode](https://code.visualstudio.com/)：代码编辑器/IDE，推荐的[插件和设置](../.vscode/vscode常用插件%26设置.md)
- 截图工具：[pixpin](https://pixpin.com/)
- [localsend](https://localsend.org/)：局域网文件传输。

可选：

- [scrcpy](https://github.com/Genymobile/scrcpy)：通过ADB控制安卓手机。
- 视频播放器：[PotPlayer](https://potplayer.daum.net/) 或 [vlc](https://www.videolan.org/)
- [Audacity](https://www.audacityteam.org/)：录制和编辑音频。

## 性能优化

- [Win11Debloat](https://github.com/Raphire/Win11Debloat)：卸载预装软件的powershell脚本。终端管理员运行：
  ```sh
  & ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
  ```
- [winutil](https://github.com/ChrisTitusTech/winutil)：另一个windows精简优化脚本。终端管理员运行：
  ```sh
  irm "https://christitus.com/win" | iex
  ```
- [WinToys](https://apps.microsoft.com/detail/9p8ltpgcbzxd?hl=zh-cn&gl=US)：提供windows进阶选项，这个在 Microsoft Store里。

## 功能定制

这一部分大部分参考了[这个视频](https://www.bilibili.com/video/BV1TxBNBsErQ)。

- [powertoys](https://github.com/microsoft/PowerToys)：提供了各种有用的工具。
- [everything](https://www.voidtools.com/zh-cn/)：速度极快的文件搜索工具，相关工具：
  - [everything-powertoys](https://github.com/lin-ycv/EverythingPowerToys/wiki) 使得可以在`powertoys-run`中使用`everything`（需要分别安装三个工具）
  - [everything-toolbar](https://github.com/srwi/EverythingToolbar)：在任务栏的搜索中使用 everything。
- [altsnap](https://github.com/RamonUnch/AltSnap)：按住 alt 即可拖动窗口。
- [NileSoft-Shell](https://nilesoft.org/)：类win10的右键菜单样式
- [icon-viewer](https://www.botproductions.com/iconview/iconview.html)：右键属性页查看/保存图标文件
- [AutoHotKey](https://www.autohotkey.com/)：自定义脚本快捷键
