# ssh使用技巧

## 实用技巧

### 设置服务器别名

编辑 `~/.ssh/config`，修改 `Host`：

```sh
Host myserver
  HostName example.com
  User myname
```

之后就可以用别名来登录该服务器了

```sh
ssh myserver
```

### 设置服务器登录终端

除了在服务器端用 `chsh` 命令设置之外，也可以在 `~/.ssh/config` 中设置：

```sh
Host myserver
    HostName example.com
    User myname
    # 登录后直接运行某个 shell（需为绝对路径）
    RemoteCommand /usr/bin/fish -l
    RequestTTY yes
```

等价的命令是：

```sh
ssh -t -o "RemoteCommand=/usr/bin/fish -l" myname@example.com
```

注意：`-t` 不能省，否则 `fish` 没有 TTY 会变成非交互模式。

## 我遇到过的问题

### 在kitty上用ssh登录提示 terminfo 相关报错

[kitty FAQ](https://sw.kovidgoyal.net/kitty/faq/)

解决问题最简单的方法是在 ssh 命令前加 `kitten`。如

```sh
kitten ssh myserver
```
