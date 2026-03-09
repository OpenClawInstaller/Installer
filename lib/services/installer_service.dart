import 'dart:io';

/// 安装类型
enum InstallType { local, docker, script }

/// 环境检测结果
class EnvCheckResult {
  final bool nodeInstalled;
  final String? nodeVersion;
  final bool dockerInstalled;
  final String? dockerVersion;
  final bool openclawInstalled;
  final String? openclawVersion;

  const EnvCheckResult({
    required this.nodeInstalled,
    this.nodeVersion,
    required this.dockerInstalled,
    this.dockerVersion,
    required this.openclawInstalled,
    this.openclawVersion,
  });

  bool get canInstallLocal => nodeInstalled;
  bool get canInstallDocker => dockerInstalled;
}

/// OpenClaw 安装服务
class InstallerService {
  /// 解析 node 版本字符串，返回 (是否满足22+, 版本号)
  static ({bool ok, String version}) _parseNodeVersion(String stdout) {
    final version = stdout.trim().replaceAll('v', '');
    final major = int.tryParse(version.split('.').first) ?? 0;
    return (ok: major >= 22, version: version);
  }

  /// 尝试用指定路径检测 Node.js
  static Future<({bool installed, String? version})> _tryNodeAt(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) return (installed: false, version: null);
      final result = await Process.run(path, ['--version']);
      if (result.exitCode == 0) {
        final parsed = _parseNodeVersion(result.stdout.toString());
        return (installed: parsed.ok, version: parsed.version);
      }
    } catch (_) {}
    return (installed: false, version: null);
  }

  /// 检测 Node.js（兼容 nvm/fnm/Homebrew 等，解决 macOS GUI 应用 PATH 不完整问题）
  static Future<({bool installed, String? version})> checkNodeJs() async {
    // 1. 先尝试直接调用 node（PATH 正常时）
    try {
      final result = await Process.run('node', ['--version']);
      if (result.exitCode == 0) {
        final parsed = _parseNodeVersion(result.stdout.toString());
        return (installed: parsed.ok, version: parsed.version);
      }
    } catch (_) {}

    // 2. macOS/Linux: 尝试常见安装路径（nvm、fnm、Homebrew、官方安装包）
    if (Platform.isMacOS || Platform.isLinux) {
      final home = Platform.environment['HOME'] ?? '';
      if (home.isNotEmpty) {
        final candidates = <String>[
          '/usr/local/bin/node',
          '/opt/homebrew/bin/node',
          '$home/.fnm/current/bin/node',
        ];
        for (final p in candidates) {
          final r = await _tryNodeAt(p);
          if (r.installed) return r;
        }
        // 扫描 nvm 目录下所有已安装版本
        final nvmDir = Directory('$home/.nvm/versions/node');
        if (await nvmDir.exists()) {
          await for (final v in nvmDir.list()) {
            if (v is Directory) {
              final nodePath = '${v.path}/bin/node';
              final r = await _tryNodeAt(nodePath);
              if (r.installed) return r;
            }
          }
        }
        // 扫描 fnm 目录
        final fnmDir = Directory('$home/.fnm/node-versions');
        if (await fnmDir.exists()) {
          await for (final v in fnmDir.list()) {
            if (v is Directory) {
              final nodePath = '${v.path}/installation/bin/node';
              final r = await _tryNodeAt(nodePath);
              if (r.installed) return r;
            }
          }
        }
      }
    }

    // 3. 尝试通过 login shell 获取完整 PATH（nvm/fnm 等）
    if (Platform.isMacOS || Platform.isLinux) {
      final shell = Platform.environment['SHELL'] ?? '/bin/zsh';
      try {
        final result = await Process.run(
          shell,
          ['-l', '-c', 'node --version'],
          runInShell: false,
        );
        if (result.exitCode == 0) {
          final parsed = _parseNodeVersion(result.stdout.toString());
          return (installed: parsed.ok, version: parsed.version);
        }
      } catch (_) {}
    }

    return (installed: false, version: null);
  }

  /// 检测 Docker
  static Future<({bool installed, String? version})> checkDocker() async {
    try {
      final result = await Process.run('docker', ['--version']);
      if (result.exitCode == 0) {
        final version = (result.stdout as String).trim();
        return (installed: true, version: version);
      }
    } catch (_) {}
    return (installed: false, version: null);
  }

  /// 检测 Docker Compose（支持 v2 docker compose 和 v1 docker-compose）
  static Future<bool> checkDockerCompose() async {
    // 优先尝试 docker compose (v2)
    try {
      final result = await Process.run('docker', ['compose', 'version']);
      if (result.exitCode == 0) return true;
    } catch (_) {}
    // 回退到 docker-compose (v1)
    try {
      final result = await Process.run('docker-compose', ['--version']);
      if (result.exitCode == 0) return true;
    } catch (_) {}
    return false;
  }

  /// 检测 OpenClaw
  static Future<({bool installed, String? version})> checkOpenClaw() async {
    try {
      final result = await Process.run('openclaw', ['--version']);
      if (result.exitCode == 0) {
        final version = (result.stdout as String).trim();
        return (installed: true, version: version);
      }
    } catch (_) {}
    return (installed: false, version: null);
  }

  /// 全面环境检测
  static Future<EnvCheckResult> checkEnvironment() async {
    final node = await checkNodeJs();
    final docker = await checkDocker();
    final openclaw = await checkOpenClaw();

    return EnvCheckResult(
      nodeInstalled: node.installed,
      nodeVersion: node.version,
      dockerInstalled: docker.installed,
      dockerVersion: docker.version,
      openclawInstalled: openclaw.installed,
      openclawVersion: openclaw.version,
    );
  }

  /// 在 macOS/Linux 上通过 login shell 执行命令（确保 nvm/fnm 等 PATH 生效）
  static Future<ProcessResult> _runWithLoginShell(String command) async {
    final shell = Platform.environment['SHELL'] ?? '/bin/zsh';
    return Process.run(shell, ['-l', '-c', command], runInShell: false);
  }

  /// 本地安装 OpenClaw (npm)
  static Stream<String> installLocal() async* {
    yield '正在通过 npm 安装 OpenClaw...';

    try {
    ProcessResult result;
    if (Platform.isMacOS || Platform.isLinux) {
      result = await _runWithLoginShell('npm install -g openclaw@latest');
    } else {
      result = await Process.run('npm', ['install', '-g', 'openclaw@latest']);
    }
      if (result.exitCode != 0) {
        yield '安装失败: ${result.stderr}';
        return;
      }
      yield 'OpenClaw 安装成功！';
      yield '正在运行配置向导...';

    ProcessResult onboardResult;
    if (Platform.isMacOS || Platform.isLinux) {
      onboardResult = await _runWithLoginShell('openclaw onboard --install-daemon');
    } else {
      onboardResult = await Process.run(
        'openclaw',
        ['onboard', '--install-daemon'],
      );
    }
      if (onboardResult.exitCode != 0) {
        yield '配置向导可能需要手动运行: openclaw onboard --install-daemon';
      } else {
        yield '配置完成！';
      }
    } catch (e) {
      yield '安装出错: $e';
    }
  }

  /// 获取 OpenClaw Docker 项目目录路径（用户主目录下的 openclaw-docker）
  static Future<String> _getOpenClawDockerDir() async {
    final home = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        (Platform.environment['HOMEDRIVE'] ?? '') +
            (Platform.environment['HOMEPATH'] ?? '.');
    final base = Platform.isWindows
        ? home.replaceAll('\\', '/')
        : home;
    return '$base/openclaw-docker';
  }

  /// 生成 docker-compose.yml 内容（参考腾讯云 Docker 部署教程）
  static String _getDockerComposeContent() {
    const tz = 'Asia/Shanghai';
    return '''
# OpenClaw Docker Compose 配置
# 参考: https://cloud.tencent.com/developer/article/2629022
version: '3.8'

services:
  openclaw:
    image: ghcr.io/openclaw/openclaw:latest
    container_name: openclaw
    ports:
      - "18789:18789"
    volumes:
      - ./data:/home/node/.openclaw
      - ./config:/app/config
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - NODE_ENV=production
      - TZ=$tz
      - OPENCLAW_PORT=18789
      - OPENCLAW_HOST=0.0.0.0
    restart: unless-stopped
    networks:
      - openclaw-net

networks:
  openclaw-net:
    driver: bridge
''';
  }

  /// 生成 openclaw-docker 目录下的 README 内容
  static String _getDockerReadmeContent() {
    return r'''
OpenClaw Docker 部署
====================

控制面板: http://127.0.0.1:18789/

常用命令:
  启动:   docker compose up -d
  停止:   docker compose down
  重启:   docker compose restart openclaw
  日志:   docker logs -f openclaw
  更新:   docker compose pull && docker compose up -d

备份数据: tar -czvf openclaw-backup-$(date +%Y%m%d).tar.gz ./data/
''';
  }

  /// Docker 方式安装 OpenClaw（支持 docker-compose 与 docker run 两种方式）
  static Stream<String> installDocker() async* {
    yield '正在拉取 OpenClaw Docker 镜像...';

    try {
      // 先停止并删除已存在的容器（忽略错误）
      await Process.run('docker', ['stop', 'openclaw']);
      await Process.run('docker', ['rm', 'openclaw']);

      final pullResult = await Process.run(
        'docker',
        ['pull', 'ghcr.io/openclaw/openclaw:latest'],
      );

      if (pullResult.exitCode != 0) {
        yield '拉取镜像失败: ${pullResult.stderr}';
        return;
      }

      yield '镜像拉取成功';

      final useCompose = await checkDockerCompose();
      if (useCompose) {
        yield '检测到 Docker Compose，使用 Compose 方式部署...';

        final projectDir = await _getOpenClawDockerDir();
        final dir = Directory(projectDir);
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }

        final composeFile = File('$projectDir/docker-compose.yml');
        await composeFile.writeAsString(_getDockerComposeContent());
        yield '已创建配置: $projectDir/docker-compose.yml';

        // 创建 data 和 config 目录
        await Directory('$projectDir/data').create(recursive: true);
        await Directory('$projectDir/config').create(recursive: true);

        // 写入 README 说明常用维护命令
        await File('$projectDir/README.txt')
            .writeAsString(_getDockerReadmeContent());

        final composeArgs = ['compose', '-f', composeFile.path, 'up', '-d'];
        final composeResult = await Process.run('docker', composeArgs,
            workingDirectory: projectDir);

        if (composeResult.exitCode != 0) {
          yield 'Docker Compose 启动失败: ${composeResult.stderr}';
          yield '尝试使用 docker run 方式...';
          yield* _installDockerRun();
        } else {
          yield 'OpenClaw Docker 容器已启动（Compose 方式）！';
          yield '项目目录: $projectDir';
          yield '数据目录: $projectDir/data';
          yield '配置目录: $projectDir/config';
        }
      } else {
        yield '未检测到 Docker Compose，使用 docker run 方式...';
        yield* _installDockerRun();
      }

      yield '控制面板: http://127.0.0.1:18789/';
      yield '首次使用请访问控制面板完成配置。';
    } catch (e) {
      yield '安装出错: $e';
    }
  }

  /// 使用 docker run 方式启动（无 Compose 时的回退方案）
  static Stream<String> _installDockerRun() async* {
    final home = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        (Platform.environment['HOMEDRIVE'] ?? '') +
            (Platform.environment['HOMEPATH'] ?? '.');
    final volumePath = Platform.isWindows
        ? '${home.replaceAll('\\', '/')}/.openclaw'
        : '$home/.openclaw';

    yield '正在启动容器...';

    final args = <String>[
      'run',
      '-d',
      '--name',
      'openclaw',
      '-v',
      '$volumePath:/home/node/.openclaw',
      '-p',
      '18789:18789',
      '--restart',
      'unless-stopped',
      '-e',
      'NODE_ENV=production',
      '-e',
      'TZ=Asia/Shanghai',
    ];

    if (!Platform.isWindows) {
      args.addAll(['-v', '/var/run/docker.sock:/var/run/docker.sock']);
    }

    args.add('ghcr.io/openclaw/openclaw:latest');

    final runResult = await Process.run('docker', args);

    if (runResult.exitCode != 0) {
      yield '启动容器失败: ${runResult.stderr}';
      return;
    }

    yield 'OpenClaw Docker 容器已启动！';
    yield '数据目录: $volumePath';
  }

  /// 使用官方脚本安装 (macOS/Linux/Windows)
  static Stream<String> installWithScript() async* {
    yield '正在下载并执行官方安装脚本...';

    try {
      if (Platform.isWindows) {
        yield '执行: iwr -useb https://openclaw.ai/install.ps1 | iex';
        final scriptResult = await Process.run(
          'powershell',
          ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command',
           'iwr -useb https://openclaw.ai/install.ps1 | iex'],
          runInShell: true,
        );

        if (scriptResult.exitCode != 0) {
          yield '脚本执行遇到问题: ${scriptResult.stderr}';
          yield '尝试使用 npm 安装...';
          yield* installLocal();
          return;
        }
      } else {
        yield '执行: curl -fsSL https://openclaw.ai/install.sh | bash';
        final scriptResult = await Process.run(
          'bash',
          ['-c', 'curl -fsSL https://openclaw.ai/install.sh | bash'],
          runInShell: true,
        );

        if (scriptResult.exitCode != 0) {
          yield '脚本执行遇到问题: ${scriptResult.stderr}';
          yield '尝试使用 npm 安装...';
          yield* installLocal();
          return;
        }

        yield '安装完成！';
        yield '正在运行配置向导...';
        final onboardResult = Platform.isMacOS || Platform.isLinux
            ? await _runWithLoginShell('openclaw onboard --install-daemon')
            : await Process.run('openclaw', ['onboard', '--install-daemon']);
        if (onboardResult.exitCode != 0) {
          yield '请手动运行: openclaw onboard --install-daemon';
        } else {
          yield '配置完成！';
        }
        return;
      }

      yield '安装完成！';
    } catch (e) {
      yield '安装出错: $e';
      yield '尝试使用 npm 安装...';
      yield* installLocal();
    }
  }

  /// 打开 Dashboard
  static Future<void> openDashboard() async {
    const url = 'http://127.0.0.1:18789/';
    if (Platform.isWindows) {
      await Process.run('cmd', ['/c', 'start', url]);
    } else if (Platform.isMacOS) {
      await Process.run('open', [url]);
    } else {
      await Process.run('xdg-open', [url]);
    }
  }
}
