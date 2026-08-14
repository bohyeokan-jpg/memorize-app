import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MemorizeApp()));
}

class MemorizeApp extends StatelessWidget {
  const MemorizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '영어 단어 앱',
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
