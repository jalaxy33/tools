# pi安装配置指南

[`pi`](https://pi.dev/) 是类似于 `claude-code` 的 agent cli 工具，特点是简洁，默认的 system prompt 极少，且可以方便的扩展。

## 安装

安装前请确保已经安装了 Node.js 和 npm。

安装命令：

```sh
# npm安装
npm install -g @mariozechner/pi-coding-agent

# pnpm安装
pnpm add -g @earendil-works/pi-coding-agent

# bun安装
bun add -g @earendil-works/pi-coding-agent
```

然后使用 `pi` 启动 cli 工具。

## 配置 API 提供商

### 方式一：编辑配置文件

在 `~/.pi/agent/auth.json` 中配置 API 提供商的密钥，可以同时配置多个提供商，参考 [docs/providers.md](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/providers.md) 文档。

下面是配置 GLM、MiniMax 和 kimi 的 coding plan 的示例：

```json
{
  "zai": { "type": "api_key", "key": "..." },
  "minimax-cn": { "type": "api_key", "key": "sk-cp-..." },
  "kimi-coding": { "type": "api_key", "key": "sk-kimi-..." }
}
```

配置好之后，重启 `pi` 使用 `/model` 选择模型即可。

### 方式二：环境变量

参考 [docs/providers.md](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/providers.md) 文档，设置相应的环境变量，重启终端和 `pi`，使用 `/model` 选择模型即可。

以下是一些例子：

- bash/zsh:

  ```sh
  # GLM
  export ZAI_API_KEY="..."
  # minimax-cn
  export MINIMAX_CN_API_KEY="sk-cp-..."
  # kimi-coding
  export KIMI_API_KEY="sk-cp-..."
  ```

- fish：

  ```sh
  set -x ZAI_API_KEY "..."
  set -x MINIMAX_CN_API_KEY "sk-cp-..."
  set -x KIMI_API_KEY "sk-cp-..."
  ```

## 使用skills

pi 能自动识别 `.agents/skills` 目录下的 skills。推荐的 skills 可以看[这篇文档](/claude/docs/skills推荐.md)。

如果同时使用 claude，建议将 skills 统一放在 `~/.agents/skills/` 目录下，然后软链接到 `~/.claude/skills/` 中。

> 这个操作可以在 cc-switch 设置：「设置」>「通用」> 「Skills存储位置」

## 安装扩展

`pi` 是极简的 agent cli 工具，只提供最简单的功能。但是扩展性极强，可以在[扩展商店](https://pi.dev/packages)里查看可用的扩展以及对应的安装方式。

常用命令：

```sh
# 安装扩展
pi install <extension-name>

# 卸载扩展
pi uninstall <extension-name>
```

怎么找扩展：

- [官方扩展商店](https://pi.dev/packages)：官方扩展商店，有时候有点慢
- [npm仓库](https://www.npmjs.com/search?q=keywords:pi-extension)：搜索框加上 `keywords:pi-extension`
- Github

## 我在用的一些扩展

### 必要功能

- [`pi-mcp-adapter`](https://www.npmjs.com/package/pi-mcp-adapter)：MCP适配器
- [`pi-subagents`](https://www.npmjs.com/package/pi-subagents)：创建subagent
- [`@plannotator/pi-extension`](https://www.npmjs.com/package/@plannotator/pi-extension)：提供计划模式。这个插件可以对计划文档进行划线批注。
- [`@juicesharp/rpiv-ask-user-question`](https://www.npmjs.com/package/@juicesharp/rpiv-ask-user-question)：向用户询问具体细节
- [`@juicesharp/rpiv-todo`](https://www.npmjs.com/package/@juicesharp/rpiv-todo)：todo 列表渲染
- [`@rhedbull/pi-permissions`](https://www.npmjs.com/package/@rhedbull/pi-permissions)：提供类似于 claude code 的权限模式

### 能力拓展

- [`pi-web-access`](https://www.npmjs.com/package/pi-web-access)：联网搜索
- [`@juicesharp/rpiv-btw`](https://www.npmjs.com/package/@juicesharp/rpiv-btw): 提供 `/btw` 命令。可以在主要任务执行过程中问一些无关的问题，对话不进入上下文。
- [`context-mode`](https://www.npmjs.com/package/context-mode): 节约上下文
- [`rtk`](https://github.com/rtk-ai/rtk)：节省执行 bash 命令时的 token 消耗，安装后使用 `rtk init --agent pi` 配置。
