# 部署到 Vercel 指南

本项目已准备好部署到 Vercel。Vercel 官方对 Astro 有原生支持，部署后会自动识别构建命令并输出静态站点。

## 前置要求

- GitHub 账号
- Vercel 账号（可用 GitHub 账号直接登录）
- 已安装 GitHub CLI（`gh`）和 Git（如果 Windows 上没有，先安装：https://cli.github.com/ 和 https://git-scm.com/）

## 最快部署方式：运行一键脚本

我已经帮你配置好 Git 远程仓库地址（`https://github.com/zhoutao-ai/codex-claude-guide.git`）。

你只需：

1. 打开文件资源管理器，进入项目目录：
   ```
   C:/Users/GIGABYTE/WorkBuddy/2026-06-29-13-21-15/codex-claude-site
   ```
2. 双击运行 **`deploy-to-github.cmd`**
3. 如果提示未登录 GitHub，按提示完成登录（浏览器授权即可）
4. 脚本会自动创建 GitHub 仓库并推送代码
5. 脚本最后会显示 Vercel 导入链接，复制到浏览器打开即可

## 手动部署步骤

如果你不想运行脚本，也可以按下面步骤手动操作：

### 1. 在 GitHub 创建仓库

1. 打开 https://github.com/new
2. 填写仓库名称，例如 `codex-claude-guide`
3. 选择 **Public**（或 Private，但 Vercel 免费版对 Private 仓库有限制）
4. 不要勾选 README / .gitignore / license（本地已有 .gitignore）
5. 点击 **Create repository**

### 2. 推送本地代码到 GitHub

拿到 GitHub 仓库地址后，在项目目录执行：

```bash
cd C:/Users/GIGABYTE/WorkBuddy/2026-06-29-13-21-15/codex-claude-site

git remote add origin https://github.com/zhoutao-ai/codex-claude-guide.git
git branch -M main
git push -u origin main
```

如果使用 SSH，则把远程地址改为：

```bash
git remote add origin git@github.com:zhoutao-ai/codex-claude-guide.git
```

### 3. 在 Vercel 导入仓库

1. 打开 https://vercel.com/new
2. 点击 **Import Git Repository**
3. 选择刚才创建的 `codex-claude-guide` 仓库
4. 在配置页面确认：
   - **Framework Preset**: `Astro`
   - **Build Command**: `astro build`
   - **Output Directory**: `dist`
5. 点击 **Deploy**

### 4. 等待部署完成

Vercel 会自动安装依赖、执行构建、部署上线。完成后会得到类似下面的域名：

```
https://codex-claude-guide-zhoutao-ai.vercel.app
```

或者直接打开 Vercel 导入链接：

```
https://vercel.com/new/import?repository-url=https://github.com/zhoutao-ai/codex-claude-guide
```

## 后续更新

代码修改后，只需重新推送到 GitHub，Vercel 会自动重新部署：

```bash
git add .
git commit -m "update content"
git push
```

## 常见问题

### 构建失败怎么办？

确保 Vercel 的项目设置里：
- Framework Preset 是 **Astro**
- Node.js 版本 >= 18
- 环境变量中没有冲突的 `ASTRO_TELEMETRY_DISABLED`

### 想自定义域名？

在 Vercel 项目控制台 -> **Domains** -> 添加自己的域名，按提示配置 DNS。

### 不想公开源码？

Vercel 免费版支持 Private GitHub 仓库，但功能有限制。也可以升级到 Pro 获得更多私有部署配额。

## 备选：CloudStudio 快速预览

如果你暂时不想注册 GitHub/Vercel，也可以使用 WorkBuddy CloudStudio 沙箱直接部署 `dist/` 目录，立即获得一个可访问的预览链接。

---

项目路径：`C:/Users/GIGABYTE/WorkBuddy/2026-06-29-13-21-15/codex-claude-site`
