import 'package:flutter_test/flutter_test.dart';

import 'package:openclaw_installer/main.dart';

void main() {
  testWidgets('OpenClaw Installer app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const OpenClawInstallerApp());
    // 等待环境检测完成（Process.run）
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text('选择安装方式'), findsOneWidget);
  });
}
