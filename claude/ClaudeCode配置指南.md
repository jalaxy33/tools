参考[这个页面](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E5%9C%A8-claude-code-for-vs-code-%E6%8F%92%E4%BB%B6%E4%B8%AD%E4%BD%BF%E7%94%A8)。有两种使用方式：

1. 使用 CLI 命令行工具
2. 在 IDE 中使用

我的配置文件可以在[这里](https://github.com/jalaxy33/.configs/tree/main/.claude)找到。

## 开源模型推荐

如果想使用开源模型，目前推荐这些（2026/02/01）：

- [Deepseek V3.2](https://api-docs.deepseek.com/zh-cn/guides/anthropic_api)：极致性价比，擅长数学推理。缺点是幻觉率较高。
- [GLM-4.7](http://docs.bigmodel.cn/cn/coding-plan/tool/claude-for-ide)：全能，擅长全栈开发、python，前端审美优秀，Agent能力强。缺点是稳定性有待提升。
- [MiniMax M2.1](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools)：擅长后端开发（Rust/Go/Java/C++），屎山代码重构首选。缺点是反应速度较慢。
- [Kimi K2.5](https://platform.moonshot.cn/docs/guide/kimi-k2-5-quickstart)：【待考查】支持视觉与文本多模态，提出了Agent Swarm功能（目前只能在网页端使用）。官方文档写得一般，编程能力有待考查。

具体情况可以参考[这个视频](https://www.bilibili.com/video/BV1QLiiByEqz/)。

## 使用CLI工具

### 安装 Claude Code

按照说明[安装 Claude Code](https://code.claude.com/docs/en/setup)。之后运行一次命令生成配置文件：

```sh
claude
```

### 国内用户配置

国内用户会被提示不支持当前国家地区，参考[这个教程](https://www.cnblogs.com/gordonMlxg/articles/19103691)，修改配置文件：

```sh
vim ~/.claude.json
```

在最后添加（不要复制注释）：

```json
{
  // ...,
  // 注意在之前的最后一项后面添加英文逗号
  "hasCompletedOnboarding": true
}
```

### 使用官方服务

如果购买了官方的服务，运行 `claude` 命令 > 输入 `/login` 登录。

### 使用开源模型

目前大部分的模型都提供了 Anthropic API 接入方式，请查询对应的 API 文档。

1. 首先确保清除以下 Anthropic 相关的环境变量，以免影响其他 API 的正常使用：

- `ANTHROPIC_AUTH_TOKEN`
- `ANTHROPIC_BASE_URL`

1. 【方式一：自动配置】使用 [cc-switch](https://github.com/farion1231/cc-switch)。这个工具可以快速切换 Claude Code 的 API 配置，安装后启动软件，添加 API 供应商和对应的 API Key 即可。

2. 【方式二：手动配置】编辑 Claude Code 的配置文件：

    ```sh
    vim ~/.claude/settings.json
    ```

    以 [MiniMax M2.1](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E9%85%8D%E7%BD%AE-minimax-api) 为例，将 `"ANTHROPIC_AUTH_TOKEN"` 字段换成自己的 key：

    ```json
    {
      "env": {
        "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
        "ANTHROPIC_AUTH_TOKEN": "<YOUR_API_KEY>",
        "API_TIMEOUT_MS": "3000000",
        "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
        "ANTHROPIC_MODEL": "MiniMax-M2.1",
        "ANTHROPIC_SMALL_FAST_MODEL": "MiniMax-M2.1",
        "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M2.1",
        "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M2.1",
        "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M2.1"
      }
    }
    ```

## 在vscode中使用

先**安装 `Claude Code for VS Code` 扩展**。如果要使用开源模型，修改 vscode 的设置：

- 如果安装了 CLI 工具，**保持默认就行**。也可以修改扩展设置，指定要用的模型：

  ```json
    {
      "claude-code.selectedModel": "MiniMax-M2.1",
    }
  ```

- 如果没有安装 CLI 工具，配置会复杂一点

    以 [MiniMax M2.1](https://platform.minimaxi.com/docs/guides/text-ai-coding-tools#%E5%9C%A8-claude-code-for-vs-code-%E6%8F%92%E4%BB%B6%E4%B8%AD%E4%BD%BF%E7%94%A8) 为例，将 `"ANTHROPIC_AUTH_TOKEN"` 字段换成自己的 key：

    ```json
    {
      "claudeCode.environmentVariables": [
        {
          "name": "ANTHROPIC_BASE_URL",
          "value": "https://open.bigmodel.cn/api/anthropic"
        },
        {
          "name": "ANTHROPIC_AUTH_TOKEN",
          "value": "<YOUR_API_KEY>"
        },
        {
          "name": "API_TIMEOUT_MS",
          "value": "3000000"
        },
        {
          "name": "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC",
          "value": "1"
        },
        {
          "name": "ANTHROPIC_MODEL",
          "value": "MiniMax-M2.1"
        },
        {
          "name": "ANTHROPIC_SMALL_FAST_MODEL",
          "value": "MiniMax-M2.1"
        },
        {
          "name": "ANTHROPIC_DEFAULT_SONNET_MODEL",
          "value": "MiniMax-M2.1"
        },
        {
          "name": "ANTHROPIC_DEFAULT_OPUS_MODEL",
          "value": "MiniMax-M2.1"
        },
        {
          "name": "ANTHROPIC_DEFAULT_HAIKU_MODEL",
          "value": "MiniMax-M2.1"
        }
      ],
    }
    ```

- 其他有用的设置

    ```json
    {
        "claudeCode.autosave": false,
        "claudeCode.useCtrlEnterToSend": true,
        "claudeCode.preferredLocation": "sidebar",
    }
    ```

## 其他使用技巧

### 删除历史对话记录

- 删除某个历史对话

    ```sh
    claude
    ```

    ```sh​
    /resume  # 选择对话
    /clear   # 清除历史记录
    ```

- 删除所有历史记录

    删除 `~/.claude/` 目录下的以下文件和文件夹：

    ```sh
    rm -rf ~/.claude/{cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
    ```

### 安装插件

1. 运行 claude

    ```sh
    claude
    ```

2. （可选）添加官方插件商城

    ```
    /plugin
    ```

    按右箭头选中 `Marketplaces` 标签，选择 「+ Add Marketplace」回车，输入仓库名称后回车：

    ```
    anthropics/claude-plugins-official
    ```

3. 然后就可以用 `/plugin install <插件名>` 或者在 `/plugin` > `Discover` 下安装插件了。

**插件推荐**：

- [code-simplifier](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-simplifier)
- [superpowers](https://github.com/obra/superpowers)

### Agent skills

Agent skills 是最近很火的一种 AI 工作流概念，能够告诉智能体在特定场景下"如何组合使用这些工具"。可以参考[官方文档](https://code.claude.com/docs/en/skills)来学习如何编写和使用 skills。

推荐的参考资料：

- 官方文档：[skills](https://code.claude.com/docs/en/skills)
- 视频：[彻底搞懂Agent skill！从概念到实战，上手玩转skill](https://www.bilibili.com/video/BV182z5BRE4f/)
- 视频：[手把手彻底学会 Agent Skills！【小白教程】](https://www.bilibili.com/video/BV1G3FNznEiS/)
- 博客：[Agent Skills 与 MCP：智能体能力扩展的两种范式](https://github.com/datawhalechina/hello-agents/blob/main/Extra-Chapter/Extra05-AgentSkills%E8%A7%A3%E8%AF%BB.md)
