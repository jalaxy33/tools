# plugin插件推荐

plugin 是将一系列 skills、MCP、hooks 打包在一起的工具集合。注意 plugin 功能只有 claude 能用，并且不是跨 agent 复用的，新添加的 agent 需要重新再设置。

安装插件的一般过程：「安装市场 > 搜索插件 > 安装插件」

- 添加市场：

  对话框输入 `/plugin` 回车 > 移动到「Marketplaces」标签页 > 选择「Add Marketplace」> 输入 `repo-owner/repo-name`

  或者一句命令添加：

  ```sh
  /plugin marketplace add <repo-owner>/<repo-name>
  ```

- 添加插件：

  在添加市场后，对话框输入 `/plugin` 回车 > 移动到「Discover」标签页 > 输入框搜索插件名 > 找到想要安装的插件，按空格选中（可多选）> 按 `i` 安装

  或者一句命令添加：

  ```sh
  /plugin install <插件名>
  # 完整命令：
  /plugin install <插件名>@<市场名>
  ```

- 卸载插件：

  输入 `/plugin` 回车 > 移动到「Installed」标签页 > 找到需要卸载的插件，回车选择「Uninstall」

## 官方插件

仓库名：[anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official)

- [`superpowers`](https://github.com/obra/superpowers) **(推荐)** ：是一套 skills 集合，提供了一系列增强工作流程的能力
- 不同编程语言的 LSP 插件，如 `rust-analyzer-lsp`

## 第三方插件

### claude-hud（推荐）

仓库地址：[jarrodwatts/claude-hud](https://github.com/jarrodwatts/claude-hud)

配置 claude 状态栏，实时显示正在发生的事情——上下文使用率、活跃工具、运行中的 Agent 和待办进度。始终在你的输入下方可见。

安装步骤：

```sh
# 添加市场
/plugin marketplace add jarrodwatts/claude-hud

# 安装插件
/plugin install claude-hud

# 重新加载插件
/reload-plugins

# 配置状态栏
/claude-hud:setup
```

### context-mode（试用中）

仓库地址：[mksglu/context-mode](https://github.com/mksglu/context-mode)

context-mode 是一个 MCP 服务器，用于节省上下文。

安装步骤：

```sh
# 添加市场
/plugin marketplace add mksglu/context-mode

# 安装插件
/plugin install context-mode@context-mode

# 重新加载插件
/reload-plugins
```

### claude-mem（试用中）

仓库地址：[thedotmack/claude-mem](https://github.com/thedotmack/claude-mem)

claude-mem 是一个为 Claude Code 提供“长期记忆”的工具，让 Claude Code 能够跨会话、跨项目地记住你的偏好、代码逻辑和技术决策

安装方法：

- 通过 npm 安装：

  ```sh
  npx claude-mem install
  ```

  会自动为 claude、Codex 等 CLI 工具安装

- 通过插件安装：

  ```sh
  # 添加市场
  /plugin marketplace add thedotmack/claude-mem

  # 安装插件
  /plugin install claude-mem

  # 重新加载插件
  /reload-plugins
  ```

启用插件后，会启动一个后台服务，可以在 <http://localhost:37700> 实时查看内存流。对话记忆以 SQLite 格式持久保存在 `~/.claude-mem/` 目录下。

### rtk

仓库地址：[rtk-ai/rtk](https://github.com/rtk-ai/rtk)

用于节省执行 bash 命令时的 token 消耗。

在按照说明安装 rtk 之后，运行命令为 claude 配置 hook：

```sh
rtk init -g
```
