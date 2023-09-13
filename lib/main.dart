import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/package.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  

  await Hive.initFlutter();

  // Hive.registerAdapter(UserSchemaAdapter());
  // Hive.registerAdapter(PreferenceSchemaAdapter());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: BouncingScrollWrapper.builder(context, child!),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'VyNeh',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primarySwatch: const MaterialColor(
          0xFF000000,
          <int, Color>{
            50: Color(0xff333333),
            100: Color(0xff333333),
            200: Color(0xff333333),
            300: Color(0xff333333),
            400: Color(0xff333333),
            500: Color(0xff333333),
            600: Color(0xff333333),
            700: Color(0xff333333),
            800: Color(0xff333333),
            900: Color(0xff333333),
          },
        ),
      ),
      routes: routes,
      initialRoute: Splash.route,
    );
  }
}
