# 应用商店自动上传配置说明

推送版本 Tag（如 `v1.0.0`）时，`release.yml` 会构建各平台产物并**尝试**上传到以下商店。  
未配置对应 Secret 时，上传步骤会 `continue-on-error`，不影响 GitHub Release 的创建与其他平台的构建。

本项目仅支持桌面端（Windows、macOS、Linux），无移动端。

请在仓库 **Settings → Secrets and variables → Actions** 中按需添加以下 Secret。

---

## 1. Snap Store (Linux)

- **Secret 名称**：`SNAPCRAFT_TOKEN`
- **获取方式**：
  1. 在 [Snapcraft](https://snapcraft.io) 登录
  2. 在 [Account → API tokens](https://dashboard.snapcraft.io/dev/account/auth-tokens) 创建 Token
  3. 或本地执行：
     ```bash
     snapcraft export-login --snaps=openclaw-installer --acls=package_access,package_push,package_update,package_release -
     ```
  4. 将输出内容完整保存为 Secret 的值（多行粘贴）
- **说明**：未配置时 Snap 仍会尝试构建并上传到 GitHub Release，但不会发布到 Snap Store。

---

## 2. Microsoft Store (Windows MSIX)

- **Secret 名称**（四个）：
  - `MS_STORE_CLIENT_ID`：Azure AD 应用 (Client) ID
  - `MS_STORE_CLIENT_SECRET`：Azure AD 应用密钥
  - `MS_STORE_TENANT_ID`：Azure AD 租户 ID
  - `MS_STORE_APP_ID`：Partner Center 中该应用的 ID（在「应用标识」页可查）
- **获取方式**：
  1. 在 [Partner Center](https://partner.microsoft.com/dashboard) 中已有该应用（至少创建过一次提交）
  2. 在 Azure AD 中注册应用，并将该应用关联到 Partner Center 账户
  3. 创建客户端密钥，记录 Client ID、Tenant ID、Client Secret
  4. 在 Partner Center 的「应用标识」中查看 **应用 ID**，填入 `MS_STORE_APP_ID`
- **自动化脚本**：  
  当前使用 `.github/scripts/upload-ms-store.ps1`。完整自动提交可安装 [StoreBroker](https://github.com/microsoft/StoreBroker) 模块并在此脚本中调用其提交命令，或参考 [Partner Center 提交 API](https://learn.microsoft.com/en-us/windows/apps/publish/partner-center-submit-api) 自行实现。

---

## 3. Apple App Store Connect（macOS）

- **Secret 名称**（三个）：
  - `APPSTORE_ISSUER_ID`：App Store Connect API 的 Issuer ID
  - `APPSTORE_API_KEY_ID`：API Key 的 Key ID
  - `APPSTORE_API_PRIVATE_KEY`：API 私钥 `.p8` 文件的**完整内容**
- **获取方式**：
  1. 登录 [App Store Connect](https://appstoreconnect.apple.com/) → 用户与访问 → 密钥 → App Store Connect API
  2. 创建 API 密钥，下载 `.p8`（仅能下载一次），并记录 Key ID 与 Issuer ID
  3. 将 `.p8` 文件内容完整粘贴为 `APPSTORE_API_PRIVATE_KEY`
- **说明**：
  - **macOS**：上传到 TestFlight 通常需要已签名的 `.pkg` 或符合 App Store 要求的 `.app`。若当前仅构建 DMG，需在 workflow 中增加签名与打包步骤后再上传。

---

## 汇总：需在 GitHub 配置的 Secret

| 商店 | Secret 名称 | 说明 |
|------|-------------|------|
| Snap Store | `SNAPCRAFT_TOKEN` | snapcraft export-login 输出 |
| Microsoft Store | `MS_STORE_CLIENT_ID`, `MS_STORE_CLIENT_SECRET`, `MS_STORE_TENANT_ID`, `MS_STORE_APP_ID` | Azure AD + Partner Center 应用 ID |
| Apple (macOS) | `APPSTORE_ISSUER_ID`, `APPSTORE_API_KEY_ID`, `APPSTORE_API_PRIVATE_KEY` | App Store Connect API 密钥 |
