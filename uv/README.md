# uv使用技巧

## 常见问题

### pytorch使用国内源

在项目的 `pyproject.toml` 中添加：

```toml
[tool.uv.sources]
torch = [{ index = "pytorch-cu132" }]
torchvision = [{ index = "pytorch-cu132" }]
torchaudio = [{ index = "pytorch-cu132" }]

[[tool.uv.index]]
name = "pytorch-cu132"
url = "https://mirror.sjtu.edu.cn/pytorch-wheels/cu132"
explicit = true
```

url 里的 `cu132` 表示使用 CUDA13.2，要使用其他版本做相应修改即可。

