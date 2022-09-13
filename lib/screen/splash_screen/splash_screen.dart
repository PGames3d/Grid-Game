import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gridgame/router/app_routs.gr.dart';

import '../../utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

const colorizeColors = [
  Colors.white,
  Color(0xff4C7AD9),
  Color(0xffC0D136),
  Color(0xff08D13F),
  Colors.white,
];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //Timer for goes to next screen after finishing splash screen
    Timer(
      const Duration(seconds: 5),
      () => context.replaceRoute(const MainMenuScreen()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _mobile(),
    );
  }

  _mobile() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Positioned(
              bottom: 120,
              top: 0,
              left: 0,
              right: 160,
              child: Center(
                  child: AnimatedTextKit(
                repeatForever: false,
                animatedTexts: [
                  RotateAnimatedText("Mobigic's",
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: "poppins_medium",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      duration: const Duration(seconds: 10)),
                ],
              )

                  //  Text(
                  //   "Mobigic's",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontFamily: "poppins_medium",
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20),
                  // ),
                  )),
          Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 60,
              child: Center(
                  child: AnimatedTextKit(
                repeatForever: false,
                animatedTexts: [
                  ScaleAnimatedText('Grid',
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: "poppins_bold",
                          fontWeight: FontWeight.bold,
                          fontSize: 100),
                      duration: const Duration(seconds: 10)),
                ],
              )

                  //  Text(
                  //   "Grid",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontFamily: "poppins_bold",
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 100),
                  // ),
                  )),
          Positioned(
              bottom: 0,
              top: 120,
              left: 92,
              right: 0,
              child: Center(
                  child: AnimatedTextKit(
                repeatForever: false,
                animatedTexts: [
                  ScaleAnimatedText('Search',
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 80),
                      duration: const Duration(seconds: 10)),
                ],
              )

                  //  Text(
                  //   "Game",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 80),
                  // ),
                  )),
        ],
      ),
    );
  }
}
