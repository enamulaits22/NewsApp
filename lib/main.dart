import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/db/database_service.dart';
import 'package:news_app/core/di/dependency_injection.dart';
import 'package:news_app/settings/theme_provider/theme_notifier.dart';
import 'package:news_app/bottom_navbar.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    DatabaseService.instance.initDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.read(themeProvider.notifier).getThemeValueFromSharedPref();
        ThemeState state = ref.watch(themeProvider);
        return MaterialApp(
          title: 'News app',
          debugShowCheckedModeBanner: false,
          theme: state.selectedTheme,
          home: const BottomNavBar(),
        );
      },
    );
  }
}
