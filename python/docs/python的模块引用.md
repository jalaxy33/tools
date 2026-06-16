# python的模块引用

## 模块内部的相互引用

现在有一个模块，其目录结构如下：

```sh
mod
├── __init__.py
├── a.py
└── b.py
```

在 `b.py` 中引用 `a.py` 中的函数 `func_a`。由于已经有 `__init__.py`，直接引用即可：

```py
# b.py
from a import func_a
```

### 设置ty插件提示

如果模块目录不是项目的一级目录，则 `ty` 插件会因为无法找到模块提示找不到模块。需要对插件进行额外设置。
在项目根目录创建 `ty.toml` 文件，设置 `extra_paths` 添加模块目录：

```toml
# ty.toml

[environment]
extra_paths = ["src/mod"]   # 假设模块目录是 src/mod
```

## 同级目录模块间的引用

```sh
.
├── a.py
└── b.py
```

在 `b.py` 中引用 `a.py` 中的函数 `func_a`：

```py
# b.py
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent))

from a import func_a
```
