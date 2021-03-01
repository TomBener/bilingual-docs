# 一份 Markdown，输出中英双语两份文件

> 详细介绍：[中英双语写作，输出指定语言 - TomBen’s 博客](https://blog.retompi.com/post/input-bilingual-output-either-en-or-cn/) | [如何在 Markdown 中双语写作，输出英文或中文？- 少数派](https://sspai.com/post/65305)

## 使用

**两种使用方式：**

### 1. 使用 Shell 脚本

- 生成英文文件

```sh
# 使 Shell 脚本可执行
$ chmod +x en.sh

# 执行 Shell 脚本
$ ./en.sh
```

- 生成中文文件

```sh
# 使 Shell 脚本可执行
$ chmod +x cn.sh

# 执行 Shell 脚本
$ ./cn.sh
```

### 2. 使用 Makefile

```makefile
# 生成英文文件
make en

# 生成中文文件
make cn

# 生成中英文文件
make  # or `make all`

# 删除生成的所有文件
make clean
```

## License

[MIT License](LICENSE)
