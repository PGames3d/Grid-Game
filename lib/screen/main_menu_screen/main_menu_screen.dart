import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gridgame/model/choice_model.dart';
import 'package:gridgame/router/app_routs.gr.dart';
import 'package:gridgame/utils/constants.dart';
import 'package:gridgame/utils/responsive.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  TextEditingController rowController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  TextEditingController textController = TextEditingController();
  int maxCharacter = 100;
  int remaningCharacter = 0;
  List<Choice> characters = [];
  @override
  void initState() {
    characters = [];
    maxCharacter = 100;
    remaningCharacter = 0;
    rowController = TextEditingController();
    columnController = TextEditingController();
    textController = TextEditingController();
    perfomMath();
    super.initState();
  }

  @override
  void dispose() {
    rowController.removeListener(() {});
    columnController.removeListener(() {});
    textController.removeListener(() {});
    rowController.dispose();
    columnController.dispose();
    textController.dispose();
    super.dispose();
  }

  bool validation() {
    String message = "";
    if (rowController.text.isEmpty) {
      message = "Please enter row count";
    } else if (int.parse(rowController.text) < 1) {
      message = "Row min count should be 1";
    } else if (columnController.text.isEmpty) {
      message = "Please enter column count";
    } else if (int.parse(columnController.text) < 1) {
      message = "Column min count should be 1";
    } else if (int.parse(columnController.text) > 10) {
      message = "Column max count should be 10";
    } else if (textController.text.isEmpty) {
      message = "Please enter some characters";
    } else if (remaningCharacter > maxCharacter) {
      message = "You have entered more characters than max characters";
    }

    if (message.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            width: Global.width(context),
            child: Column(
              children: [
                const Text(
                  "Info",
                  style: TextStyle(fontSize: 20, fontFamily: "poppins_bold"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return message.isEmpty;
  }

  perfomMath() {
    rowController.addListener(() {
      if (columnController.text.isNotEmpty && rowController.text.isNotEmpty) {
        int m = int.parse(rowController.text);
        int n = int.parse(columnController.text);
        setState(() {
          maxCharacter = m * n;
        });
      }
    });

    columnController.addListener(() {
      if (columnController.text.isNotEmpty && rowController.text.isNotEmpty) {
        int m = int.parse(rowController.text);
        int n = int.parse(columnController.text);
        setState(() {
          maxCharacter = m * n;
        });
      }
    });

    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        setState(() {
          remaningCharacter = textController.text.length;
        });
      } else {
        remaningCharacter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _mobile(context),
    );
  }

  _mobile(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
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
          const Positioned(
            top: 20,
            left: 16,
            right: 0,
            child: Text(
              "Grid",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "poppins_bold",
                  fontWeight: FontWeight.bold,
                  fontSize: 60),
            ),
          ),
          const Positioned(
            top: 70,
            left: 46,
            right: 0,
            child: Text(
              "Search",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
          Positioned(
            top: 40,
            left: 200,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  rotateText(text: "AWESOME"),
                  rotateText(text: "Mobigic's"),
                  rotateText(text: 'GAMES ARE'),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    side: MaterialStateProperty.all(const BorderSide(
                        style: BorderStyle.solid,
                        strokeAlign: StrokeAlign.inside,
                        width: 3,
                        color: Colors.white)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrangeAccent)),
                onPressed: () {
                  if (validation()) {
                    characters = List<Choice>.generate(
                        maxCharacter,
                        (index) => index < textController.text.length
                            ? Choice(
                                title: textController.text[index],
                                isFound: true,
                              )
                            : Choice(title: ""));

                    context.pushRoute(GridScreen(
                        choice: characters,
                        columnCount: int.parse(columnController.text)));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: const Text(
                    "START GAME",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "poppins_bold",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 20,
              left: 20,
              child: InkWell(
                onTap: () => dialogHelp(context),
                child: const Icon(
                  Icons.help_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              )),
          Positioned(
              bottom: Global.height(context) / 2,
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                  child: Image.asset(
                "assets/images/mobigic_logo.png",
                height: 100,
              ))),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () => dialogInfo(context),
                child: const Icon(
                  Icons.info_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              )),
          const Positioned(
              bottom: 250,
              right: 0,
              left: 0,
              top: 0,
              child: Center(
                  child: Text(
                "Generate Grid?",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ))),
          Positioned(
              bottom: 170,
              right: 0,
              left: 0,
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Row's",
                    style: textStyle,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Col's",
                    style: textStyle,
                  )
                ],
              )),
          Positioned(
              bottom: 100,
              right: 0,
              left: 0,
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      controller: rowController,
                      maxLines: 1,
                      style: textStyle,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        isDense: true,
                        hintText: "10",
                        fillColor: Colors.white,
                        hintStyle: textStyle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: TextFormField(
                      controller: columnController,
                      maxLines: 1,
                      style: textStyle,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        isDense: true,
                        hintText: "10",
                        fillColor: Colors.white,
                        hintStyle: textStyle,
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: Global.width(context) / 1.3,
              top: 10,
              child: Center(
                child: Text(
                  "$remaningCharacter/$maxCharacter",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 100,
            child: Center(
              child: Container(
                width: Global.width(context),
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: textController,
                  style: textStyle,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    isDense: true,
                    hintText: "Enter max $maxCharacter characters here",
                    fillColor: Colors.white,
                    hintStyle: textStyle,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }

  final textStyle = const TextStyle(color: Colors.white, fontSize: 20);

  Future<dynamic> dialogInfo(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 230,
              width: Global.width(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: const [
                  Text(
                    "ABOUT US",
                    style: TextStyle(
                        fontFamily: "poppins_bold",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "This is test project provided by Mobigic® Technologies Private Limited",
                    style: TextStyle(
                      fontFamily: "poppins_medium",
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Design and Developed by : Parshuram Pathave",
                    style: TextStyle(
                      fontFamily: "poppins_bold",
                      fontSize: 18,
                    ),
                  ),
                ]),
              ),
            ),
          );
        }));
  }

  Future<dynamic> dialogHelp(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 220,
              width: Global.width(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Center(
                      child: Text("HOW TO PLAY",
                          style: TextStyle(
                              fontFamily: "poppins_bold",
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "1. Enter row count",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "2. Enter column count",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "3. Enter aplphabets/text characters upto max count",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "4. Click On Start Game",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "5. On next screen search words or aplphabets",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  RotateAnimatedText rotateText({required String text}) {
    return RotateAnimatedText(
      text,
      textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: "poppins_medium",
          fontWeight: FontWeight.bold,
          fontSize: 30),
    );
  }
}
