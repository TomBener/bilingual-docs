# 一份 Markdown，输出中英双语两份文档

## 使用

**两种使用方式：**

### 1. 使用 Shell 脚本

- 生成英文文档

```sh
# 使 Shell 脚本可执行
$ chmod +x en.sh

# 执行 Shell 脚本
$ ./en.sh
```

- 生成中文文档

```sh
# 使 Shell 脚本可执行
$ chmod +x cn.sh

# 执行 Shell 脚本
$ ./cn.sh
```

### 2. 使用 Makefile

```makefile
# 生成英文文档
make en

# 生成中文文档
make cn

# 删除生成的所有文档
make clean
```
