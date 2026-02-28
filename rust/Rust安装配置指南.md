# Rust安装配置指南

## 安装

1. 设置 Rustup 镜像：
    - bash/zsh

        ```sh
        export RUSTUP_DIST_SERVER="https://rsproxy.cn"
        export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
        ```

    - fish

        ```sh
        set -x RUSTUP_DIST_SERVER "https://rsproxy.cn"
        set -x RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"
        ```

2. 然后执行脚本安装 `rustup`：

    ```sh
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ```

    虽然也能通过 pacman 等包管理器安装，但是这样就无法使用 `rustup self update` 更新工具链了。因此如果是打算rust编程，建议使用脚本安装的方式。

3. 激活环境
    - bash/zsh

        ```sh
        . "$HOME/.cargo/env"
        ```

    - fish

        ```sh
        source "$HOME/.cargo/env.fish"
        ```

## 设置 crates.io 镜像

编辑 `~/.cargo/config.toml` 用户配置文件：

```sh
vim ~/.cargo/config.toml
```

```toml
[source.crates-io]
replace-with = 'ustc'

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"

[registries.ustc]
index = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
```

## 推荐：更换 mold 链接器

[mold](https://github.com/rui314/mold) 是比官方链接器更快的的链接器，推荐使用。

1. 安装 `mold` 和 `clang`

    ```sh
    sudo pacman -S --needed mold clang

    # 也可以顺便把LLVM工具链装上
    sudo pacman -S --needed clang llvm lldb lld libc++
    ```

2. 然后在项目的 `.cargo/config.toml` 或用户全局 `~/.cargo/config.toml` 中写入：

    ```toml
    [target.'cfg(target_os = "linux")']
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=/usr/bin/mold"]
    ```

    其他使用方式请查看[官方文档](https://github.com/rui314/mold?tab=readme-ov-file#how-to-use)。

其他提升rust编译速度的优化方案可以参考 [Bevy 的文档](https://bevy.org/learn/quick-start/getting-started/setup/#enable-fast-compiles-optional)

## 安装 `cargo-cache` 工具

这个工具用来清理 cargo 的全局下载缓存。

- 安装：

    ```sh
    cargo install cargo-cache
    ```

- 清理缓存：

    ```sh
    cargo cache -e
    ```

## 可选：安装 nightly 工具链

nightly工具链提供了实验性工具，独立于稳定版工具链，有需要再装。

- 安装：

    ```sh
    rustup toolchain install nightly
    ```

- 查看工具链版本

    ```sh
    rustup run nightly rustc --version
    ```

- 可选：设为默认工具链（默认为 `stable`）

    ```sh
    rustup default nightly
    ```

- 更新所有工具链

    ```sh
    rustup update
    ```
