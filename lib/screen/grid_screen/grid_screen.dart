import 'dart:collection';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gridgame/model/choice_model.dart';

import 'package:gridgame/utils/responsive.dart';

import '../../utils/constants.dart';
import 'components/tile.dart';

// ignore: must_be_immutable
class GridScreen extends StatefulWidget {
  List<Choice> choice = [];
  int columnCount = 0;
  GridScreen({super.key, required this.choice, required this.columnCount});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController textController = TextEditingController();

  var indexList = [];
  HashSet hashSet = HashSet();
  bool findEachCharacter = false;
  @override
  void initState() {
    findEachCharacter = false;
    textController = TextEditingController();

    searchAlgorithm();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  searchAlgorithm() {
    textController.addListener(() {
      //check value
      if (textController.text.isNotEmpty) {
        //reset all the values
        for (var element in widget.choice) {
          element.title.isNotEmpty
              ? element.isFilled = true
              : element.isFilled = false;
          element.isFound = false;
        }
        //temp list fromation
        List<Choice> tempList = List<Choice>.generate(
            textController.text.length,
            (index) => Choice(title: textController.text[index]));

        // find the occurence index
        for (int i = 0; i < widget.choice.length; i++) {
          Choice ch = widget.choice[i];
          for (int k = 0; k < tempList.length; k++) {
            if (ch.title
                .toLowerCase()
                .contains(tempList[k].title.toLowerCase())) {
              findEachCharacter
                  ? setState(() {
                      ch.isFilled = true;
                      ch.isFound = true;
                      widget.choice[i] = ch;
                    })
                  : indexList.add(i);
            }
          }
        }

        //destinguish arraylist - remove duplicates
        indexList = [
          ...{...indexList}
        ];

        if (kDebugMode) {
          print(indexList);
        }
      }
    });
  }

  searchWholeText() {
    indexList.reversed;
    if (indexList.isNotEmpty) {
      bool isFound = false;
      bool isDuplicate = false;
      if (indexList.length > 1) {
        if (checkDirection()) {
          //increasing or decresing
          isFound = true;
        } else if (checkDuplicate()) {
          //increasing or decresing
          isFound = false;
          //not working
          isDuplicate = false;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Duplicate alphabets found")));
        } else if (checkTopDown()) {
          //topdown
          isFound = true;
        } else if (checkDiagonal()) {
          //diagonal
          isFound = true;
        } else {
          //not found
          isFound = false;
        }
      } else {
        //if array have 1 element
        isFound = true;
      }

      if (isFound) {
        setState(() {
          for (int i = 0; i < indexList.length; i++) {
            Choice ch = widget.choice[indexList[i]];
            ch.isFilled = true;
            ch.isFound = true;
            widget.choice[indexList[i]] = ch;
          }
        });
      } else if (isDuplicate) {
        setState(() {
          for (int i = 0; i < duplicateArray.length; i++) {
            int index = widget.choice.indexOf(duplicateArray[i]);
            if (kDebugMode) {
              print(index);
            }
            Choice ch = widget.choice[index];
            ch.isFilled = true;
            ch.isFound = true;
            widget.choice[index] = ch;
          }
        });
      }
    }
  }

  checkDiagonal() {
    bool isDiagonal = false;
    for (int i = 0; i < indexList.length - 1; i++) {
      if (((indexList[i] - indexList[i + 1]) == widget.columnCount - 1) ||
          ((indexList[i + 1] - indexList[i]) == widget.columnCount - 1) ||
          ((indexList[i] - indexList[i + 1]) == widget.columnCount + 1) ||
          ((indexList[i + 1] - indexList[i]) == widget.columnCount + 1)) {
        //it is diagonal
        isDiagonal = true;
      } else {
        isDiagonal = false;
        break;
      }
    }
    return isDiagonal;
  }

  checkTopDown() {
    bool isTopDown = false;
    for (int i = 0; i < indexList.length - 1; i++) {
      if (((indexList[i] - indexList[i + 1]) == widget.columnCount) ||
          ((indexList[i + 1] - indexList[i]) == widget.columnCount)) {
        //it is diagonal
        isTopDown = true;
      } else {
        isTopDown = false;
        break;
      }
    }
    return isTopDown;
  }

  List<Choice> duplicateArray = [];
  checkDuplicate() {
    bool isDuplicate = false;

    duplicateArray = [];
    if (indexList.length > textController.text.length) {
      isDuplicate = true;
      for (int i = 0; i < indexList.length; i++) {
        duplicateArray.add(widget.choice[indexList[i]]);
      }
      setState(() {
        duplicateArray = [
          ...{...duplicateArray}
        ];
      });
    }
    return isDuplicate;
  }

  checkDirection() {
    bool isIncreasing = false;
    for (int i = 0; i < indexList.length - 1; i++) {
      if (((indexList[i + 1] - indexList[i]) == 1) ||
          ((indexList[i] - indexList[i + 1]) == 1)) {
        //it is diagonal
        isIncreasing = true;
      } else {
        isIncreasing = false;
        break;
      }
    }
    return isIncreasing;
  }

  Future<dynamic> dialogHelp(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              height: 170,
              width: Global.width(context),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text("Search Mode",
                        style: TextStyle(
                            fontFamily: "poppins_bold",
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 40,
                      width: Global.width(context),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurple)),
                        onPressed: () {
                          setState(() {
                            findEachCharacter = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Search mode changed")));
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Full Text Search Mode",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 40,
                      width: Global.width(context),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurple)),
                        onPressed: () {
                          setState(() {
                            findEachCharacter = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Search mode changed")));
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Character Search Mode",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
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
                    fontSize: 50),
              ),
            ),
            const Positioned(
              top: 70,
              left: 46,
              right: 0,
              child: Text(
                "Match",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            Positioned(
              top: 40,
              left: 250,
              right: 0,
              child: Center(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Unfilled",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        color: Colors.deepOrangeAccent,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Filled",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Highlited",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  )
                ],
              )

                  // AnimatedTextKit(
                  //   repeatForever: true,
                  //   animatedTexts: [
                  //     rotateText(text: "AWESOME"),
                  //     rotateText(text: "Mobigic's"),
                  //     rotateText(text: 'GAMES ARE'),
                  //   ],
                  // ),
                  ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              top: 100,
              child: Container(
                width: Global.width(context),
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (!findEachCharacter) {
                      searchWholeText();
                      setState(() {
                        indexList = [];
                        textController.clear();
                      });
                    }
                  },
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
                    hintText: "Search....",
                    fillColor: Colors.white,
                    hintStyle: textStyle,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 200,
                left: 0,
                bottom: 60,
                right: 0,
                child: Container(
                  width: Global.width(context),
                  color: Colors.white70,
                )),
            Positioned(
              top: 200,
              left: 0,
              bottom: 60,
              right: 0,
              child: GridView.count(
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,
                  crossAxisCount: widget.columnCount,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  children: List.generate(widget.choice.length, (index) {
                    return Center(
                      child: TileCard(
                          choice: widget.choice[index],
                          columnCount: widget.columnCount),
                    );
                  })),
            ),
            Positioned(
                left: 0,
                bottom: 56,
                right: 0,
                child: Container(
                  width: Global.width(context),
                  height: 4,
                  color: Colors.white,
                )),
            Positioned(
                left: 0,
                top: 196,
                right: 0,
                child: Container(
                  width: Global.width(context),
                  height: 4,
                  color: Colors.white,
                )),
            Positioned(
                left: 0,
                bottom: 10,
                right: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      dialogHelp(context);
                    },
                    child: Text(
                      "Change Search Mode",
                      style: textStyle,
                    ),
                  ),
                )),
          ],
        ));
  }

  RotateAnimatedText rotateText({required String text}) {
    return RotateAnimatedText(
      text,
      textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: "poppins_medium",
          fontWeight: FontWeight.bold,
          fontSize: 20),
    );
  }

  final textStyle = const TextStyle(color: Colors.white, fontSize: 20);
}
