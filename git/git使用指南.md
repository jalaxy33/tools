
## 全局设置

- 设置代理（将7890换成自己的端口）
  ```sh
  git config --global http.proxy http://127.0.0.1:7890
  git config --global https.proxy http://127.0.0.1:7890
  ```

- 取消代理

  ```sh
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  ```

- 新项目自动设置push分支
  ```sh
  git config --global push.autoSetupRemote true
  ```

- 设置免验证push/pull（只需要验证一次）
  ```sh
  git config --global credential.helper store
  ```

- 设置默认分支为main

  ```sh
  git config --global init.defaultBranch main
  ```


## 项目设置

- 新项目设置用户名和邮箱（第一次commit前）
  ```sh
  git config user.name "Your Name"
  ```
  ```sh
  git config user.email "you@example.com"
  ```

- 修改当前项目的分支为main

  ```sh
  git branch -M main
  ```


## 常用命令

### 分支管理

- 查看本地所有分支
  ```sh
  git branch
  ```

- 切换分支
  ```sh
  git checkout <分支名>
  ```

- 创建并切换到新分支：
  ```sh
  git checkout -b <分支名>
  ```

- 合并分支：将其他分支的提交合并至本分支
  ```sh
  git merge <其他分支名>
  ```

- 删除分支：
  ```sh
  git branch -d <分支名>
  ```

### 版本管理

- 暂存更改
    ```sh
    git stash
    ```

- 恢复暂存的更改
    ```sh
    git stash pop
    ```

- 恢复所有修改并删除未跟踪文件
    ```sh
    git checkout -- . && git clean -fd
    ```

### 标签管理

- 查看所有tag：
    ```sh
    git tag -l
    ```

- 创建tag：
    ```sh
    # 添加注解（推荐）
    git tag -a <tagname>

    # 不添加注解
    git tag <tagname>

    # 为指定commit追加tag
    git tag -a <tagname> <commit-hash>
    ```

- 复用tag：
    ```sh
    # 复用到当前commit
    git tag -f <tagname>
    
    # 复用到指定commit
    git tag -f <tagname> <commit-hash>
    ```

- 推送tag到远程
    ```sh
    git push -u origin <tagname>

    # 推送所有tag
    git push -u origin --tags

    # 覆盖已存在的tag
    git push --force origin <tagname>
    ```

- 删除tag
    ```sh
    # 本地删除
    git tag -d <tagname>

    # 远程删除
    git push -u origin --delete <tagname>
    ```


## 规范

- [Commit message 和 Change log 编写指南](https://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
- [Commit格式规范](https://doris.apache.org/zh-CN/community/how-to-contribute/commit-format-specification)


## 遇到过的问题

### 修改历史commits中的用户名和邮箱

1. 在项目目录下创建一个脚本，下面是Linux/Mac下的例子：
    ```sh
    #!/bin/sh
    git filter-branch --env-filter '
    OLD_EMAIL="原来的邮箱"
    CORRECT_NAME="现在的名字"
    CORRECT_EMAIL="现在的邮箱"
    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags
    ```

2. 然后用 `chmod +x <脚本名>.sh` 赋予执行权限后运行脚本，或者直接用 bash 运行这个脚本。
    
    > 如果运行失败，先执行下面的命令：
    > ```sh
    > git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD
    > ```
    > 然后再尝试执行

3. 执行完成后，查看 `git log` 可以看到已经修改成功。
4. 如果要推送到远程：
    ```sh
    git push origin --force --all
    ```
    去看一下 Github 你就会发现之前的提交记录中，name 和 email 信息都更新了。


### 历史提交中包含了大文件

这种情况在将代码推送到远程库时不太方便，如果这些大文件非必须，可以通过创建孤立分支的方式来清除历史提交记录。

1. 首先将大文件从 git 记录中删除：
    ```sh
    git rm --cached  <文件路径>
    ```
    `--cached`表示从git记录中删除而保留本地文件

2. 将大文件添加到 `.gitignore` 中
3. 提交更改
    ```sh
    git add -A
    git commit -m "Remove large files from git"
    ```
4. 创建孤立分支
    ```sh
    git checkout --orphan new-branch
    ```
5. 删除旧分支
    ```sh
    git branch -D <old-branch>
    ```
6. 重命名为旧分支，实现覆盖
    ```sh
    git branch -m <old-branch>
    ```


### 只克隆部分文件

利用 sparse-checkout 的方式

1. 首先克隆仓库，但不下载内容：
    ```sh
    git clone --filter=blob:none --no-checkout <仓库URL>
    cd <仓库目录>
    ```
    - `--filter=blob:none`：告诉 Git 不要下载任何文件内容（blob 对象），只下载 commit 和 tree 对象。
    - `--no-checkout`：克隆后不自动检出任何文件，避免触发按需下载。

2. 启用 sparse-checkout：
    ```sh
    # 启用稀疏检出，使用锥形模式（推荐）
    git sparse-checkout init --cone
    ```
    锥形模式（cone mode）会优化性能，只匹配目录层级，而不是完整路径模式。

3. 设置所需路径：

    可以用 `set` 命令快速设置，也可以手动编辑 `.git/info/sparse-checkout` 文件。默认只checkout项目根目录下的文件：
    ```sh
    git sparse-checkout set <子目录1> <子目录2>  # 设置要检出的目录/文件
    ```

4. 检出当前分支（通常是 main/master）
    ```sh
    git checkout main   # 或你需要的分支
    ```

5. 后续同步更新

    ```sh
    git pull origin main
    ```



