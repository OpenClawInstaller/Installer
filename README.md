# OpenClaw 图形化安装器

为 [OpenClaw](https://openclaw.ai) 提供的跨平台图形化安装程序，支持 Windows、macOS 和 Linux 桌面系统。

## 功能特性

- **双安装模式**：支持本地 npm 安装和 Docker 容器安装
- **环境检测**：自动检测 Node.js 22+ 和 Docker 是否已安装
- **依赖引导**：缺少环境时提供 Node.js / Docker 官方下载链接
- **一键安装**：图形化界面完成 OpenClaw 的安装与配置

## 系统要求

### 本地安装 (npm)
- **Node.js 22+**（推荐 LTS 版本）
- npm 10+ 或 pnpm 9+

### Docker 安装
- **Docker Engine** >= 20.10
- **Docker Compose** >= v2.0.0（推荐，用于 Compose 部署）
- **Docker Desktop**（Windows/macOS）或 **Docker Engine**（Linux）
- 至少 4GB 可用内存、10GB 可用磁盘空间

## 构建与运行

### 开发运行

```bash
# 安装依赖
flutter pub get

# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

### 发布构建

```bash
# macOS 应用
flutter build macos

# Windows 应用
flutter build windows

# Linux 应用
flutter build linux
```

构建产物位置：
- **macOS**: `build/macos/Build/Products/Release/openclaw_installer.app`
- **Windows**: `build/windows/runner/Release/` 目录
- **Linux**: `build/linux/x64/release/bundle/` 目录

## 命令行安装

若选择命令安装，可按平台执行以下命令：

- **macOS / Linux**：`curl -fsSL https://openclaw.ai/install.sh | bash`
- **Windows PowerShell**：`iwr -useb https://openclaw.ai/install.ps1 | iex`
- **Windows CMD**：`curl -fsSL https://openclaw.ai/install.cmd -o install.cmd && install.cmd && del install.cmd`

## 安装流程

1. **选择安装方式**
   - 本地安装：通过 npm 全局安装，需要 Node.js
   - Docker 安装：使用官方镜像运行，需要 Docker
   - 命令行安装：使用官方脚本一键安装（见上方命令）

2. **环境检测**
   - 若缺少 Node.js 或 Docker，会显示官方下载链接
   - 安装完成后重启本安装器，点击「重新检测」

3. **执行安装**
   - 本地：执行 `npm install -g openclaw@latest` 并运行配置向导
   - Docker：
     - 若有 Docker Compose：在 `~/openclaw-docker` 创建 `docker-compose.yml` 并启动
     - 若无 Compose：使用 `docker run` 直接启动容器
   - 参考：[Docker 部署 OpenClaw 完整教程](https://cloud.tencent.com/developer/article/2629022)

4. **完成**
   - 打开控制面板 http://127.0.0.1:18789/ 完成首次配置

### Docker 维护命令（Compose 方式）

部署目录为 `~/openclaw-docker`（或 `%USERPROFILE%\openclaw-docker`）：

- 启动：`docker compose up -d`
- 停止：`docker compose down`
- 重启：`docker compose restart openclaw`
- 日志：`docker logs -f openclaw`
- 更新：`docker compose pull && docker compose up -d`
- 备份：`tar -czvf openclaw-backup-$(date +%Y%m%d).tar.gz ./data/`

## OpenClaw 简介

OpenClaw 是开源的个人 AI 助手，支持：
- WhatsApp、Telegram、Discord、Slack、Signal、iMessage 等通讯渠道
- 持久化记忆与个性化配置
- 浏览器控制、文件访问、技能扩展等

官网：https://openclaw.ai

## 技术栈

- Flutter 3.x（桌面端）
- Dart 3.x

## 许可证

MIT
