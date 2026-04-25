import 'package:flutter/material.dart';
import 'package:learning_gamification/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:learning_gamification/providers/gem_provider.dart';
import 'package:learning_gamification/features/home/home_screen.dart';
import 'package:learning_gamification/features/splash/splash_screen.dart';
import 'package:learning_gamification/features/shop/shop_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GemProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark();
    final theme = base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.blueAccent,
        secondary: Colors.lightBlueAccent,
      ),
      scaffoldBackgroundColor: const Color(0xFF071428),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF061125),
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MEMSNAP',
      theme: theme,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/': (_) => const HomeScreen(),
        '/shop': (_) => const ShopScreen(),
      },
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
