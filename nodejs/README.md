# Node.js经验记录

## 安装Node.js

### 单板本

如果没有多版本需求，用包管理器安装 nodejs 和 npm 即可。

以 ArchLinux 为例：

```sh
sudo pacman -S --needed nodejs npm
```

### 多版本

如果有多版本需求，需要安装环境管理工具，推荐 [fnm](https://github.com/Schniz/fnm)，个人觉得比 nvm 好用。

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

## 更换npm国内源

- 更换为淘宝源：

    ```sh
    npm config set registry https://registry.npmmirror.com
    ```

    或者编辑 `~/.npmrc` 文件，添加以下内容：

    ```
    registry=https://registry.npmmirror.com/
    ```

- 更换为腾讯云镜像源

    ```sh
    npm config set registry http://mirrors.cloud.tencent.com/npm/
    ```

    或者编辑 `~/.npmrc` 文件，添加以下内容：

    ```
    registry=http://mirrors.cloud.tencent.com/npm/
    ```

