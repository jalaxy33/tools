# GLM 设置

模型名称：`glm-4.7`

接入文档：https://docs.bigmodel.cn/cn/coding-plan/tool/claude

**注：请将 `"ANTHROPIC_AUTH_TOKEN"` 字段更换为自己的 API key**。

- Claude Code 环境变量 `~/.claude/settings.json`：

  ```json
  {
    "env": {
      "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
      "ANTHROPIC_AUTH_TOKEN": "<YOUR_API_KEY>",
      "API_TIMEOUT_MS": "3000000",
      "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
      "ANTHROPIC_MODEL": "glm-4.7",
      "ANTHROPIC_SMALL_FAST_MODEL": "glm-4.7",
      "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-4.7",
      "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-4.7",
      "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.7"
    }
  }
  ```

- vscode 设置：
  - 如果装了命令行工具，**保持默认就行**，也可以手动指定：
    ```json
    {
      "claude-code.selectedModel": "glm-4.7"
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
          "value": "glm-4.7"
        },
        {
          "name": "ANTHROPIC_SMALL_FAST_MODEL",
          "value": "glm-4.7"
        },
        {
          "name": "ANTHROPIC_DEFAULT_SONNET_MODEL",
          "value": "glm-4.7"
        },
        {
          "name": "ANTHROPIC_DEFAULT_OPUS_MODEL",
          "value": "glm-4.7"
        },
        {
          "name": "ANTHROPIC_DEFAULT_HAIKU_MODEL",
          "value": "glm-4.7"
        }
      ]
    }
    ```

- 可选：配置MCP服务器

  **前提条件**：1. 订阅 [coding plan](https://docs.bigmodel.cn/cn/coding-plan/quick-start)；2. 安装 `npm`。

  修改 `~/.claude.json` 的 `mcpServers` 字段：

  ```sh
  vim ~/.claude.json
  ```

  在其中添加[视觉理解](https://docs.bigmodel.cn/cn/coding-plan/mcp/vision-mcp-server)、[联网搜索](https://docs.bigmodel.cn/cn/coding-plan/mcp/search-mcp-server)、[网页读取](https://docs.bigmodel.cn/cn/coding-plan/mcp/reader-mcp-server)、[开源仓库](https://docs.bigmodel.cn/cn/coding-plan/mcp/zread-mcp-server)的MCP服务器：

  > 注意将 `<your_api_key>` 换成自己的 API key

  ```json
  {
    "mcpServers": {
      "zai-mcp-server": {
        "type": "stdio",
        "command": "npx",
        "args": ["-y", "@z_ai/mcp-server"],
        "env": {
          "Z_AI_API_KEY": "<your_api_key>",
          "Z_AI_MODE": "ZHIPU"
        }
      },
      "web-search-prime": {
        "type": "http",
        "url": "https://open.bigmodel.cn/api/mcp/web_search_prime/mcp",
        "headers": {
          "Authorization": "Bearer <your_api_key>"
        }
      },
      "web-reader": {
        "type": "http",
        "url": "https://open.bigmodel.cn/api/mcp/web_reader/mcp",
        "headers": {
          "Authorization": "Bearer <your_api_key>"
        }
      },
      "zread": {
        "type": "http",
        "url": "https://open.bigmodel.cn/api/mcp/zread/mcp",
        "headers": {
          "Authorization": "Bearer <your_api_key>"
        }
      }
    }
  }
  ```
