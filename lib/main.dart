import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/pages/split_page.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS) {
    setWindowTitle('Your App');
    setWindowMinSize(const Size(960, 540));
    setWindowMaxSize(Size.infinite);
  }

  runApp(
    ChangeNotifierProvider(create: (_) => LanguageProvider(), child: MyApp()),
  );

  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setFullScreen(true);
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplitPage(),
    );
  }
}
