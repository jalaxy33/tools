# uv使用技巧

## 常见问题

### pytorch使用国内源

在项目的 `pyproject.toml` 中添加：

```toml
[tool.uv.sources]
torch = [{ index = "pytorch-cu129" }]
torchvision = [{ index = "pytorch-cu129" }]
torchaudio = [{ index = "pytorch-cu129" }]

[[tool.uv.index]]
name = "pytorch-cu129"
url = "https://mirror.sjtu.edu.cn/pytorch-wheels/cu129"
explicit = true
```

url 里的 `cu129` 表示使用 CUDA12.9，要使用其他版本做相应修改即可。

