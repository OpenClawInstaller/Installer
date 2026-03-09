# GitHub Actions 说明

## 1. 推送即构建 (`build.yml`)

- **触发**：推送到 `main` / `master` 或向这两个分支提 PR 时
- **作用**：仅做编译验证，不发布
- **产物**：
  - Linux：桌面版 bundle
  - Windows：桌面版
  - macOS：桌面版
- **产物位置**：在 Actions 运行页的 "Artifacts" 中下载

## 2. Tag 即发布 (`release.yml`)

- **触发**：推送版本 Tag，例如 `v1.0.0`（必须以 `v` 开头）
- **用法**：
  ```bash
  git tag v1.0.0
  git push origin v1.0.0
  ```
- **作用**：
  - 构建各平台发布包（Windows、macOS、Linux）
  - 创建 GitHub Release 并上传构建产物
- **应用商店自动上传（可选）**：  
  推送 Tag 时会尝试上传到 **Snap Store / Microsoft Store / Apple TestFlight**。  
  未配置对应 Secret 时上传步骤会跳过，不影响 Release。  
  详细需配置的 Secret 与获取方式见 [StoreUpload.md](doc/StoreUpload.md)。

## Flutter 版本

当前 release 使用 Flutter `3.32.8`，build 使用 `env.FLUTTER_VERSION: 3.32.8`，可在各 workflow 中按需修改。
