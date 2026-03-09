import 'dart:io';

/// 平台工具类 - 检测操作系统和架构
class PlatformUtils {
  static bool get isWindows => Platform.isWindows;
  static bool get isMacOS => Platform.isMacOS;
  static bool get isLinux => Platform.isLinux;

  /// 是否为桌面平台（支持交互式终端）
  static bool get isDesktop => isWindows || isMacOS || isLinux;

  static String get platformName {
    if (isWindows) return 'Windows';
    if (isMacOS) return 'macOS';
    if (isLinux) return 'Linux';
    return 'Unknown';
  }

  /// 检测是否为 Apple Silicon (M1/M2/M3)
  static Future<bool> get isAppleSilicon async {
    if (!isMacOS) return false;
    try {
      final result = await Process.run('uname', ['-m']);
      return result.stdout.toString().trim().contains('arm64');
    } catch (_) {
      return false;
    }
  }

  /// 检测是否为 ARM64 Windows
  static Future<bool> get isWindowsArm64 async {
    if (!isWindows) return false;
    try {
      final result = await Process.run('wmic', ['cpu', 'get', 'name']);
      return result.stdout.toString().toLowerCase().contains('arm');
    } catch (_) {
      return false;
    }
  }

  /// 获取 Node.js 下载 URL
  static Future<String> getNodeJsDownloadUrl() async {
    const version = 'v22.22.0';
    const base = 'https://nodejs.org/dist/$version';

    if (isWindows) {
      final arm64 = await isWindowsArm64;
      if (arm64) {
        return '$base/node-$version-arm64.msi';
      }
      return '$base/node-$version-x64.msi';
    }

    if (isMacOS) {
      // 使用通用 pkg 安装包
      return '$base/node-$version.pkg';
    }

    if (isLinux) {
      return '$base/node-$version-linux-x64.tar.xz';
    }

    return 'https://nodejs.org';
  }

  /// 获取 Docker 直接下载 URL（用于内置下载）
  static Future<String> getDockerDirectDownloadUrl() async {
    if (isWindows) {
      final arm64 = await isWindowsArm64;
      if (arm64) {
        return 'https://desktop.docker.com/win/main/arm64/Docker%20Desktop%20Installer.exe';
      }
      return 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe';
    }
    if (isMacOS) {
      final appleSilicon = await isAppleSilicon;
      if (appleSilicon) {
        return 'https://desktop.docker.com/mac/main/arm64/Docker.dmg';
      }
      return 'https://desktop.docker.com/mac/main/amd64/Docker.dmg';
    }
    return '';
  }

  /// 获取 Docker 下载页面 URL（浏览器打开）
  static String getDockerDownloadUrl() {
    if (isWindows) return 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe';
    if (isMacOS) return 'https://www.docker.com/products/docker-desktop/';
    if (isLinux) return 'https://docs.docker.com/engine/install/';
    return 'https://www.docker.com/products/docker-desktop/';
  }

  /// 是否支持官方脚本安装（macOS/Linux/Windows）
  static bool get supportsOfficialScript => true;

  /// 在系统终端中执行命令（新开终端窗口，用户可交互）
  /// 用于 openclaw onboard 等需要用户输入的交互式命令
  static Future<bool> openSystemTerminalWithCommand(String command) async {
    try {
      if (isWindows) {
        // cmd /k 保持窗口打开，用户可交互
        await Process.run('cmd', ['/c', 'start', 'cmd', '/k', command]);
        return true;
      }
      if (isMacOS) {
        // 使用 osascript 在 Terminal.app 新窗口中执行
        final escaped = command.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
        await Process.run('osascript', [
          '-e',
          'tell application "Terminal" to do script "$escaped"',
        ]);
        return true;
      }
      if (isLinux) {
        // 尝试常见终端模拟器，exec bash 保持窗口打开
        final cmdWithBash = '$command; exec bash';
        final attempts = [
          ['gnome-terminal', '--', 'bash', '-c', cmdWithBash],
          ['xfce4-terminal', '-e', 'bash -c "$cmdWithBash"'],
          ['konsole', '-e', cmdWithBash],
          ['xterm', '-e', cmdWithBash],
        ];
        for (final args in attempts) {
          try {
            final result = await Process.run(args.first, args.skip(1).toList());
            if (result.exitCode == 0) return true;
          } catch (_) {
            continue;
          }
        }
        return false;
      }
    } catch (_) {}
    return false;
  }
}
