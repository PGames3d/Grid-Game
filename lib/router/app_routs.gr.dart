// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../model/choice_model.dart' as _i6;
import '../screen/grid_screen/grid_screen.dart' as _i2;
import '../screen/main_menu_screen/main_menu_screen.dart' as _i3;
import '../screen/splash_screen/splash_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SplashScreen(),
          transitionsBuilder: _i4.TransitionsBuilders.zoomIn,
          opaque: true,
          barrierDismissible: false);
    },
    GridScreen.name: (routeData) {
      final args = routeData.argsAs<GridScreenArgs>();
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.GridScreen(
              key: args.key,
              choice: args.choice,
              columnCount: args.columnCount),
          transitionsBuilder: _i4.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    MainMenuScreen.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.MainMenuScreen(),
          transitionsBuilder: _i4.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(SplashScreen.name, path: '/'),
        _i4.RouteConfig(GridScreen.name, path: '/grid-screen'),
        _i4.RouteConfig(MainMenuScreen.name, path: '/main-menu-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i4.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/');

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.GridScreen]
class GridScreen extends _i4.PageRouteInfo<GridScreenArgs> {
  GridScreen(
      {_i5.Key? key,
      required List<_i6.Choice> choice,
      required int columnCount})
      : super(GridScreen.name,
            path: '/grid-screen',
            args: GridScreenArgs(
                key: key, choice: choice, columnCount: columnCount));

  static const String name = 'GridScreen';
}

class GridScreenArgs {
  const GridScreenArgs(
      {this.key, required this.choice, required this.columnCount});

  final _i5.Key? key;

  final List<_i6.Choice> choice;

  final int columnCount;

  @override
  String toString() {
    return 'GridScreenArgs{key: $key, choice: $choice, columnCount: $columnCount}';
  }
}

/// generated route for
/// [_i3.MainMenuScreen]
class MainMenuScreen extends _i4.PageRouteInfo<void> {
  const MainMenuScreen()
      : super(MainMenuScreen.name, path: '/main-menu-screen');

  static const String name = 'MainMenuScreen';
}
