import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// 交互式进程运行器 - 用于桌面平台实时显示输出并支持用户输入
class InteractiveProcessRunner {
  InteractiveProcessRunner._({
    required this.process,
    required this.outputStream,
    required this.exitCodeFuture,
  });

  final Process process;
  final Stream<String> outputStream;
  final Future<int> exitCodeFuture;

  bool _stdinClosed = false;

  /// 向进程 stdin 写入一行
  void writeLine(String text) {
    if (_stdinClosed) return;
    try {
      process.stdin.writeln(text);
      process.stdin.flush();
    } catch (_) {}
  }

  /// 关闭 stdin（进程将收到 EOF）
  void closeStdin() {
    if (_stdinClosed) return;
    _stdinClosed = true;
    try {
      process.stdin.close();
    } catch (_) {}
  }

  /// 终止进程
  void kill([ProcessSignal signal = ProcessSignal.sigterm]) {
    process.kill(signal);
  }

  /// 启动交互式进程
  static Future<InteractiveProcessRunner> start({
    required String executable,
    required List<String> arguments,
    String? workingDirectory,
    bool runInShell = false,
    Map<String, String>? environment,
  }) async {
    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      runInShell: runInShell,
      environment: environment,
      mode: ProcessStartMode.normal,
    );

    final outputController = StreamController<String>.broadcast();

    void listenStream(Stream<List<int>> stream) {
      stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
            (line) => outputController.add(line),
            onError: (e) => outputController.add('[stream error: $e]'),
          );
    }

    listenStream(process.stdout);
    listenStream(process.stderr);

    final exitCodeFuture = process.exitCode;

    return InteractiveProcessRunner._(
      process: process,
      outputStream: outputController.stream,
      exitCodeFuture: exitCodeFuture,
    );
  }

  /// 使用 shell 执行单条命令（跨平台）
  static Future<InteractiveProcessRunner> startShellCommand({
    required String command,
    String? workingDirectory,
  }) async {
    if (Platform.isWindows) {
      return start(
        executable: 'powershell',
        arguments: ['-NoProfile', '-Command', command],
        workingDirectory: workingDirectory,
        runInShell: false,
      );
    }
    final shell = Platform.environment['SHELL'] ?? '/bin/bash';
    return start(
      executable: shell,
      arguments: ['-l', '-c', command],
      workingDirectory: workingDirectory,
      runInShell: false,
    );
  }
}
