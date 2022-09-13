import 'package:auto_route/auto_route.dart';
import 'package:gridgame/screen/grid_screen/grid_screen.dart';
import 'package:gridgame/screen/main_menu_screen/main_menu_screen.dart';
import 'package:gridgame/screen/splash_screen/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: SplashScreen,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        initial: true),
    CustomRoute(
      page: GridScreen,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: MainMenuScreen,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ],
)
class $AppRouter {}
