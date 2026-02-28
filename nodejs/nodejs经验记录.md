
## 使用fnm安装Node工具链

推荐使用 [fnm](https://github.com/Schniz/fnm) 安装 node 和 npm，个人觉得比 nvm 好用。

安装fnm之后，在配置文件中添加启动命令，来使用fnm安装的node工具链：
- bash：

  ```sh
  eval "$(fnm env --use-on-cd --shell bash)"
  ```

- zsh：

  ```sh
  eval "$(fnm env --use-on-cd --shell zsh)"
  ```

- fish：

  ```sh
  fnm env --use-on-cd --shell fish | source
  ```

- powershell：

  ```sh
  fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
  ```


安装node工具链（node、npm等）：
```sh
fnm install --latest
```

检查是否生效：
```sh
npm
```


