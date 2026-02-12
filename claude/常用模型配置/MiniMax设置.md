
模型名称：`MiniMax M2.1`

**注：请将 `"ANTHROPIC_AUTH_TOKEN"` 字段更换为自己的 API key**。

- Claude Code 环境变量 `~/.claude/settings.json`：
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

- vscode 设置：
  - 如果装了命令行工具，**保持默认就行**，也可以手动指定：
    ```json
    {
      "claude-code.selectedModel": "MiniMax-M2.1",
    }
    ```
  - 如果没装命令行工具： 
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

- 可选：配置MCP服务器

    **前提条件**：1. 订阅 [coding plan](https://platform.minimaxi.com/subscribe/coding-plan)；2. 安装 [`uv`](https://docs.astral.sh/uv/)。

    修改 `~/.claude.json` 的 `mcpServers` 字段：
    ```sh
    vim ~/.claude.json
    ```

    添加 MCP 服务器设置

    ```json
    {
      "mcpServers": {
        "MiniMax": {
          "command": "uvx",
          "args": [
            "minimax-coding-plan-mcp",
            "-y"
          ],
          "env": {
            "MINIMAX_API_KEY": "填写你的API密钥",
            "MINIMAX_API_HOST": "https://api.minimaxi.com"
          }
        }
      }
    }
    ```



