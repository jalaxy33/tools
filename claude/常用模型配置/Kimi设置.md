
模型名称：`kimi-k2.5`

**注：请将 `"ANTHROPIC_AUTH_TOKEN"` 字段更换为自己的 API key**。

- Claude Code 环境变量 `~/.claude/settings.json`：
  ```json
  {
    "env": {
      "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
      "ANTHROPIC_AUTH_TOKEN": "<YOUR_API_KEY>",
      "API_TIMEOUT_MS": "3000000",
      "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1,
      "ANTHROPIC_MODEL": "kimi-k2.5",
      "ANTHROPIC_SMALL_FAST_MODEL": "kimi-k2.5",
      "ANTHROPIC_DEFAULT_SONNET_MODEL": "kimi-k2.5",
      "ANTHROPIC_DEFAULT_OPUS_MODEL": "kimi-k2.5",
      "ANTHROPIC_DEFAULT_HAIKU_MODEL": "kimi-k2.5"
    }
  }
  ```

- vscode 设置：
  - 如果装了命令行工具，**保持默认就行**，也可以手动指定：
    ```json
    {
      "claude-code.selectedModel": "kimi-k2.5",
    }
    ```
  - 如果没装命令行工具： 
    ```json
    {
      "claudeCode.environmentVariables": [
        {
          "name": "ANTHROPIC_BASE_URL",
          "value": "https://api.moonshot.cn/anthropic"
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
          "value": "kimi-k2.5"
        },
        {
          "name": "ANTHROPIC_SMALL_FAST_MODEL",
          "value": "kimi-k2.5"
        },
        {
          "name": "ANTHROPIC_DEFAULT_SONNET_MODEL",
          "value": "kimi-k2.5"
        },
        {
          "name": "ANTHROPIC_DEFAULT_OPUS_MODEL",
          "value": "kimi-k2.5"
        },
        {
          "name": "ANTHROPIC_DEFAULT_HAIKU_MODEL",
          "value": "kimi-k2.5"
        }
      ],
    }
    ``` 

