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

### 方式三：添加自定义提供商

参考 [custom-provider](https://pi.dev/docs/latest/custom-provider) 文档，通过创建或修改 `~/.pi/agent/models.json` 添加自定义提供商。

例如添加火山方舟的模型，用 `ARK_API_KEY` 环境变量来配置 api key：

```json
{
  "providers": {
    "ark": {
      "baseUrl": "https://ark.cn-beijing.volces.com/api/coding",
      "api": "anthropic-messages",
      "apiKey": "$ARK_API_KEY",
      "models": [
        {
          "id": "glm-5.1",
          "reasoning": true
        }
      ]
    }
  }
}
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

可以看我的 [pi 配置仓库](https://github.com/jalaxy33/pi-dotfiles/tree/main#extension-list)。
