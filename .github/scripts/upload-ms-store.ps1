# 将 MSIX 提交到 Microsoft Store (Partner Center)
# 需在 GitHub Secrets 中配置: MS_STORE_CLIENT_ID, MS_STORE_CLIENT_SECRET, MS_STORE_TENANT_ID, MS_STORE_APP_ID
# 参考: https://learn.microsoft.com/en-us/windows/apps/publish/partner-center-submit-api

param(
    [string]$MsixPath
)

# 若未指定路径，则自动查找 build 目录下的 .msix 文件
if (-not $MsixPath) {
    $MsixDir = "build\windows\x64\runner\Release"
    $found = Get-ChildItem -Path $MsixDir -Filter "*.msix" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) { $MsixPath = $found.FullName }
}

$clientId = $env:MS_STORE_CLIENT_ID
$clientSecret = $env:MS_STORE_CLIENT_SECRET
$tenantId = $env:MS_STORE_TENANT_ID
$appId = $env:MS_STORE_APP_ID

if (-not $clientId -or -not $clientSecret -or -not $tenantId -or -not $appId) {
    Write-Host "Microsoft Store secrets not configured, skipping upload."
    exit 0
}

if (-not $MsixPath -or -not (Test-Path $MsixPath)) {
    Write-Host "MSIX not found: $MsixPath"
    exit 0
}

# 使用 StoreBroker 或 REST API 提交
# 方式一: 安装 StoreBroker 模块并提交 (需在 Partner Center 已创建应用与至少一次提交)
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue
if (Get-Module -ListAvailable -Name StoreBroker) {
    # StoreBroker 已安装时的提交流程 (具体命令请参考 StoreBroker 文档)
    Write-Host "StoreBroker module found. Configure StoreBroker and run submission - see .github/doc/StoreUpload.md"
    exit 0
}

# 方式二: 无 StoreBroker 时仅提示
Write-Host "To automate Microsoft Store submission:"
Write-Host "1. Install StoreBroker: Install-Module StoreBroker -Scope CurrentUser"
Write-Host "2. Configure StoreBroker and call its submit commands with the above secrets."
Write-Host "3. Or use Partner Center API directly with Azure AD token (see StoreUpload.md)."
exit 0
