 # OpenClaw GUI Installer

 Cross-platform graphical installer for [OpenClaw](https://openclaw.ai), supporting Windows, macOS, and Linux desktop environments.

 ## Features

 - **Two installation modes**: local npm installation and Docker-based installation
 - **Environment checks**: automatically detects whether Node.js 22+ and Docker are installed
 - **Dependency guidance**: provides official download links for Node.js / Docker when they are missing
 - **One-click installation**: complete OpenClaw installation and basic configuration via GUI

 ## System Requirements

 ### Local installation (npm)
 - **Node.js 22+** (LTS version recommended)
 - npm 10+ or pnpm 9+

 ### Docker installation
 - **Docker Engine** >= 20.10
 - **Docker Compose** >= v2.0.0 (recommended, for Compose-based deployment)
 - **Docker Desktop** (Windows/macOS) or **Docker Engine** (Linux)
 - At least 4GB free memory and 10GB free disk space

 ## Build and Run

 ### Development run

 ```bash
 # Install dependencies
 flutter pub get

 # macOS
 flutter run -d macos

 # Windows
 flutter run -d windows

 # Linux
 flutter run -d linux
 ```

 ### Production build

 ```bash
 # macOS app
 flutter build macos

 # Windows app
 flutter build windows

 # Linux app
 flutter build linux
 ```

 Build outputs:
 - **macOS**: `build/macos/Build/Products/Release/openclaw_installer.app`
 - **Windows**: `build/windows/runner/Release/`
 - **Linux**: `build/linux/x64/release/bundle/`

 ## Command-line Installation

 If you prefer command-line installation, use:

 - **macOS / Linux**: `curl -fsSL https://openclaw.ai/install.sh | bash`
 - **Windows PowerShell**: `iwr -useb https://openclaw.ai/install.ps1 | iex`
 - **Windows CMD**: `curl -fsSL https://openclaw.ai/install.cmd -o install.cmd && install.cmd && del install.cmd`

 ## Installation Flow

 1. **Choose installation method**
    - Local: global installation via npm (requires Node.js)
    - Docker: run official Docker images (requires Docker)
    - Command-line: one-line installation using official scripts (see above)

 2. **Environment detection**
    - If Node.js or Docker is missing, the installer shows official download links
    - After installing dependencies, restart this installer and click "Re-check"

 3. **Run installation**
    - Local: runs `npm install -g openclaw@latest` and launches the configuration wizard
    - Docker:
      - With Docker Compose: creates `docker-compose.yml` in `~/openclaw-docker` and starts services
      - Without Compose: uses `docker run` to start the container directly
    - Reference: [Full Docker deployment guide for OpenClaw](https://cloud.tencent.com/developer/article/2629022)

 4. **Finish**
    - Open the control panel at http://127.0.0.1:18789/ to complete the initial setup

 ### Docker Maintenance Commands (Compose)

 Deployment directory: `~/openclaw-docker` (or `%USERPROFILE%\openclaw-docker` on Windows):

 - Start: `docker compose up -d`
 - Stop: `docker compose down`
 - Restart: `docker compose restart openclaw`
 - Logs: `docker logs -f openclaw`
 - Update: `docker compose pull && docker compose up -d`
 - Backup: `tar -czvf openclaw-backup-$(date +%Y%m%d).tar.gz ./data/`

 ## About OpenClaw

 OpenClaw is an open-source personal AI assistant with:
 - Channels such as WhatsApp, Telegram, Discord, Slack, Signal, iMessage, and more
 - Persistent memory and personalized configuration
 - Browser control, file access, extensible skills, and more

 Official site: https://openclaw.ai

 ## Tech Stack

 - Flutter 3.x (desktop)
 - Dart 3.x

 ## License

 MIT
