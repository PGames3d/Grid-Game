import 'package:flutter/material.dart';
import 'package:gridgame/model/choice_model.dart';

class TileCard extends StatelessWidget {
  const TileCard({Key? key, required this.choice, required this.columnCount})
      : super(key: key);
  final Choice choice;
  final int columnCount;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: choice.isFound != null && choice.isFound!
            ? choice.isFilled != null && choice.isFilled!
                ? Colors.deepPurple
                : Colors.amber
            : choice.isFilled != null && choice.isFilled!
                ? Colors.amber
                : Colors.orange,
        elevation: 4,
        child: Center(
          child: Text(
            choice.title,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "poppins_bold",
                fontWeight: FontWeight.bold,
                fontSize: 200 / columnCount),
          ),
        ));
  }
}
