import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// 下载进度
class DownloadProgress {
  final int received;
  final int total;
  final double percent;

  const DownloadProgress({
    required this.received,
    required this.total,
  }) : percent = total > 0 ? received / total : 0.0;
}

/// 内置下载服务
class DownloadService {
  /// 下载文件并报告进度
  static Future<File?> downloadWithProgress(
    String url, {
    required void Function(DownloadProgress) onProgress,
    String? filename,
  }) async {
    try {
      final request = http.Request('GET', Uri.parse(url));
      final client = http.Client();
      final response = await client.send(request);

      if (response.statusCode != 200) {
        return null;
      }

      final total = response.contentLength ?? 0;
      int received = 0;

      final dir = await getDownloadsDirectory() ?? await getTemporaryDirectory();
      final name = filename ?? path.basename(Uri.parse(url).path);
      final file = File(path.join(dir.path, name));

      final sink = file.openWrite();
      await for (final chunk in response.stream) {
        sink.add(chunk);
        received += chunk.length;
        onProgress(DownloadProgress(received: received, total: total));
      }
      await sink.close();
      client.close();

      return file;
    } catch (_) {
      return null;
    }
  }

  /// 打开/运行已下载的安装包
  static Future<bool> runInstaller(File file) async {
    try {
      if (Platform.isWindows) {
        await Process.run('cmd', ['/c', 'start', '', file.path]);
      } else if (Platform.isMacOS) {
        await Process.run('open', [file.path]);
      } else if (Platform.isLinux) {
        await Process.run('xdg-open', [file.path]);
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
