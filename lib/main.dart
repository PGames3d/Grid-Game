import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gridgame/preparation/first_singleton.dart';
import 'package:gridgame/utils/app_theme.dart';

import 'router/app_routs.gr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

//Testing
  // FirstSingleton f1 = FirstSingleton();
  // FirstSingleton f2 = FirstSingleton();

  // AnotherSingletonThree f1 = AnotherSingletonThree.instance;
  // AnotherSingletonThree f2 = AnotherSingletonThree.instance;

  // if (kDebugMode) {
  //   print("Parshu ${identical(f1, f2)} ${f1.hashCode} vs ${f2.hashCode}");
  // }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      // statusBarColor: Color(0xff383641)));
      statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
