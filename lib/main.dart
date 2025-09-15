import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/theme.dart';
import 'package:taskati/features/splash/splash_screen.dart';

// Applying Theme Mode
// 1) Use theme, dark theme, theme mode below MaterialApp
// 2) Add Switch Ui Widget to change theme
// 3) Use theme as bool in caching ("userBox")
// 4) Use ValueListenableBuilder to change theme and rebuild ui above MaterialApp

Future<void> main() async {
  await Hive.initFlutter();
  await LocalHelper.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalHelper.userBox.listenable(),
      builder: (context, box, child) {
        bool? isDark = box.get(LocalHelper.kIsDark);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDark == null
              ? ThemeMode.system
              : isDark == true
              ? ThemeMode.dark
              : ThemeMode.light,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
