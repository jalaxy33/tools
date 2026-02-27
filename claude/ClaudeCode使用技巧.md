# Claude Code 使用技巧

- 有用的参考资料:
  - [官方文档](https://code.claude.com/docs/en/overview)
  - [smithery](https://smithery.ai/)：MCP和skills的资源库。

## 常用快捷键和命令

快捷键：

- 切换计划模式（plan mode）：`Shift+Tab`
- 在文本编辑器编辑对话：`Crtl+g`
- 展开折叠的对话内容：`Crtl+o`

功能命令：

- 按键教程：`?`
- 推出claude-code：`/exit` 或 `exit`
- 运行命令：`!` + 命令
- 引用文件或目录作为上下文：`@` + 文件或目录路径
- 切换计划模式或查看计划：`/plan`
- 激活沙箱模式：`/sandbox`
- 在工作空间中添加新的目录：`/add-dir`
- 切换颜色主题：`/theme`

功能扩展相关命令：

- 管理插件：`/plugin`
- 管理MCP服务器：`/MCP`
- 管理skills：`/skills`
- 创建和管理agent：`/agent`
- 创建和管理hooks：`/hooks`

对话记录相关命令：

- 恢复历史对话：`/resume`
- 清除当前历史对话记录：`/clear`
- 对话历史上下文压缩：`/compact`（用来压缩过长的对话记录以节省Token）
- 退回到之前的某个对话状态：`/rewind`
- 从当前对话状态创建一个新的分支：`/fork`

## 删除历史对话记录

- 删除某个历史对话

  ```sh
  claude
  ```

  ```sh
  /resume  # 选择对话
  /clear   # 清除历史记录
  ```

- 删除所有历史记录

  删除 `~/.claude/` 目录下的以下文件和文件夹：
  - bash/zsh/fish:

    ```sh
    rm -rf ~/.claude/{backups,cache,debug,projects,shell-snapshots,statsig,telemetry,todos,file-history,plans,history.jsonl,session-env}
    ```

  - powershell:

    ```ps1
    rm "$HOME\.claude\backups","$HOME\.claude\cache","$HOME\.claude\debug",`
        "$HOME\.claude\projects","$HOME\.claude\shell-snapshots",`
        "$HOME\.claude\statsig","$HOME\.claude\telemetry","$HOME\.claude\todos",`
        "$HOME\.claude\file-history","$HOME\.claude\plans",`
        "$HOME\.claude\history.jsonl","$HOME\.claude\session-env" `
        -r -fo -EA SilentlyContinue
    ```

## 安装插件

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
- [github](https://github.com/anthropics/claude-plugins-official/tree/main/external_plugins/github)
- 编程语言相关的插件，搜索 `lsp`，如：`pyright`（python）、`rust-analyzer`（rust）、`clangd-lsp`（c/c++）等。

## 创建subagent

可以参考[这个视频](https://www.bilibili.com/video/BV1zqeMzfEiQ)和[官方文档](https://code.claude.com/docs/en/sub-agents)来学习如何使用 Claude Code 创建和使用 Agent。

创建和使用方法：

1. 创建 agent：输入 `/agent` 命令启动创建，创建后的agent描述文档在 `.claude/agents` 目录下。
2. 初始化项目：在项目目录中输入 `/init`，claude会根据 `.claude` 目录中的配置文件来初始化项目，会在项目根目录创建一个 `CLAUDE.md` 文档，用于指导AI在当前项目中的行为。
3. 使用agent：模型会从当前对话上下文中识别应用场景，自动调用相应的agent来完成任务。

## Agent skills

Agent skills 是最近很火的一种 AI 工作流概念，能够告诉智能体在特定场景下"如何组合使用这些工具"。其核心设计理念是「渐进式披露」和「按需加载」，避免一次性将过多内容塞入上下文窗口。可以参考[官方文档](https://code.claude.com/docs/en/skills)来学习如何编写和使用 skills。

推荐的参考资料：

- 官方文档：[skills](https://code.claude.com/docs/en/skills)
- 视频：[彻底搞懂Agent skill！从概念到实战，上手玩转skill](https://www.bilibili.com/video/BV182z5BRE4f/)
- 视频：[手把手彻底学会 Agent Skills！【小白教程】](https://www.bilibili.com/video/BV1G3FNznEiS/)
- 博客：[Agent Skills 与 MCP：智能体能力扩展的两种范式](https://github.com/datawhalechina/hello-agents/blob/main/Extra-Chapter/Extra05-AgentSkills%E8%A7%A3%E8%AF%BB.md)
