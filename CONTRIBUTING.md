# 贡献指南 (CONTRIBUTING)

感谢你对这个项目的关注！本指南将帮助你高效地参与项目开发。

## 📋 目录

- [行为准则](#行为准则)
- [如何报告 Bug](#如何报告-bug)
- [如何提议功能](#如何提议功能)
- [Pull Request 流程](#pull-request-流程)
- [代码规范](#代码规范)
- [提交信息约定](#提交信息约定)

---

## 行为准则

本项目遵循 [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md)。

### 我们致力于：

- 保持一个热情、包容的社区
- 尊重所有贡献者无论其背景或经验
- 提供建设性的反馈
- 关注对项目和社区最好的事

### 我们不容忍：

- 骚扰、歧视或任何形式的不尊重行为
- 侵犯隐私或任何形式的骚扰
- 商业性的不适当推广

---

## 如何报告 Bug

### 在提交 Bug 前，请检查：

1. 在 [Issues](../../issues) 中搜索是否已报告
2. 确认问题是否可重现
3. 收集系统信息（OS、Python/Node 版本等）

### 提交 Bug 报告

1. 打开 [New Issue](../../issues/new)
2. 选择 "Bug Report" 模板
3. 填写以下信息：

   ```
   **描述 Bug**
   清晰简洁的 Bug 描述。

   **复现步骤**
   1. 运行 ...
   2. 打开 ...
   3. 看到错误

   **预期行为**
   应该发生什么

   **实际行为**
   实际发生了什么

   **环境**
   - 操作系统：[e.g. Ubuntu 20.04]
   - Python 版本：[e.g. 3.9.0]
   - 项目版本：[e.g. v1.0.0]
   ```

---

## 如何提议功能

1. 在 [Issues](../../issues) 中搜索类似提议
2. 打开 [New Issue](../../issues/new)
3. 选择 "Feature Request" 模板
4. 清晰描述：
   - 功能概要
   - 使用场景
   - 预期实现方式

---

## Pull Request 流程

### 准备工作

1. **Fork** 仓库到你的账户
2. **克隆** 到本地：
   ```bash
   git clone https://github.com/yourname/yuanshikai168.git
   cd yuanshikai168
   ```
3. **添加上游仓库**：
   ```bash
   git remote add upstream https://github.com/yuanshikai168/yuanshikai168.git
   ```

### 开发流程

1. **更新本地 main**：
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **创建特性分支**：
   ```bash
   git checkout -b feature/awesome-feature
   ```
   
   分支命名规则：
   - `feature/` - 新功能
   - `fix/` - 缺陷修复
   - `docs/` - 文档更新
   - `test/` - 测试用例
   - `chore/` - 维护任务

3. **开发并提交**：
   ```bash
   git add .
   git commit -m "feat: add awesome feature"
   ```

4. **推送分支**：
   ```bash
   git push origin feature/awesome-feature
   ```

5. **创建 Pull Request**：
   - 打开仓库，GitHub 会提示创建 PR
   - 或手动访问 [Pull Requests](../../pulls)
   - 填写 PR 模板

### PR 检查清单

- [ ] 我已读过 [贡献指南](CONTRIBUTING.md)
- [ ] 我的代码遵循项目的代码规范
- [ ] 我已添加必要的测试
- [ ] 所有测试通过 (`pytest` / `npm test`)
- [ ] 我已更新相关文档
- [ ] 提交信息清晰有意义
- [ ] 没有额外的日志或调试代码

---

## 代码规范

### Python

遵循 **PEP 8** 规范：

```bash
# 使用 black 格式化
pip install black
black src/ tests/

# 使用 flake8 检查
pip install flake8
flake8 src/ tests/

# 使用 isort 整理导入
pip install isort
isort src/ tests/
```

示例：
```python
# ✅ 好的代码
def calculate_total(items: list[float]) -> float:
    """计算总和"""
    return sum(items)

# ❌ 不好的代码
def calc(items):
    return sum(items)
```

### JavaScript / TypeScript

遵循 **ESLint** 规范：

```bash
# 安装依赖
npm install

# 检查代码
npm run lint

# 自动修复
npm run lint:fix
```

示例：
```javascript
// ✅ 好的代码
async function fetchData(url: string): Promise<Data> {
  const response = await fetch(url);
  return response.json();
}

// ❌ 不好的代码
function fetchData(url) {
  fetch(url).then(r => r.json());
}
```

### Go

遵循 **golint** 规范：

```bash
# 格式化
go fmt ./...

# 检查
golint ./...

# 静态分析
go vet ./...
```

---

## 提交信息约定

使用 **Conventional Commits** 格式：

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

### 类型

- **feat** - 新功能
- **fix** - 缺陷修复
- **docs** - 文档更新
- **style** - 代码风格调整（不改逻辑）
- **refactor** - 代码重构（不改功能）
- **perf** - 性能优化
- **test** - 测试用例
- **chore** - 构建、依赖等维护任务

### 示例

```
feat(auth): add JWT token validation

- Implement JWT signature verification
- Add token expiration check
- Add security headers

Closes #123
```

```
fix(api): fix null pointer exception in data handler

The handler did not check for null values before accessing.
Now validates input and returns proper error response.

Fixes #456
```

---

## 审核过程

1. **CI 检查** - 所有自动化测试必须通过
2. **代码审核** - 至少一个维护者审核
3. **反馈** - 根据反馈进行调整
4. **合并** - 通过审核后由维护者合并

---

## 需要帮助？

- 📖 查看 [项目文档](README.md)
- 💬 在 [Discussions](../../discussions) 提问
- 📧 发送邮件到 hello@example.com

感谢你的贡献！❤️
