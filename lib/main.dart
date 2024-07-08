import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qas/presentation/page/home_page.dart';

import 'data/local/prefs.dart';
import 'presentation/page/login_page.dart';
import 'tools/res_color.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  const String scriptUrl = 'https://cdn.jsdelivr.net/npm/zxing-library@1.0.0/zxing.js';

  if (kIsWeb) {
    MobileScannerPlatform.instance.setBarcodeLibraryScriptUrl(scriptUrl);
  }
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('uz', 'UZ')],
        path: 'assets/translations',
        fallbackLocale: const Locale('uz', 'UZ'),
        child: const ProviderScope(child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: navigatorKey,
      title: "Қўшкопир Авто Савдо",
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: ResColors.mainBg),
        colorScheme: ColorScheme.fromSeed(seedColor: ResColors.mainColor),
        useMaterial3: true,
      ),
      home: checkIsLogin() == true ? const HomePage() : const LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          default:
            return null;
        }
      },
    );
  }

  checkIsLogin() async => SharedPrefs.isLogin();
}
