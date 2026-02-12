
模型名称：`Deepseek V3.2`

**注：请将 `"ANTHROPIC_AUTH_TOKEN"` 字段更换为自己的 API key**。

- Claude Code 环境变量 `~/.claude/settings.json`：
  ```json
  {
    "env": {
      "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
      "ANTHROPIC_AUTH_TOKEN": "<YOUR_API_KEY>",
      "API_TIMEOUT_MS": "3000000",
      "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
      "ANTHROPIC_MODEL": "deepseek-chat",
      "ANTHROPIC_SMALL_FAST_MODEL": "deepseek-chat",
      "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-chat",
      "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-chat",
      "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-chat"
    }
  }
  ```

- vscode 设置：
  - 如果装了命令行工具，**保持默认就行**，也可以手动指定：
    ```json
    {
      "claude-code.selectedModel": "deepseek-chat",
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
          "value": "deepseek-chat"
        },
        {
          "name": "ANTHROPIC_SMALL_FAST_MODEL",
          "value": "deepseek-chat"
        },
        {
          "name": "ANTHROPIC_DEFAULT_SONNET_MODEL",
          "value": "deepseek-chat"
        },
        {
          "name": "ANTHROPIC_DEFAULT_OPUS_MODEL",
          "value": "deepseek-chat"
        },
        {
          "name": "ANTHROPIC_DEFAULT_HAIKU_MODEL",
          "value": "deepseek-chat"
        }
      ],
    }
    ``` 
