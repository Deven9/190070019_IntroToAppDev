import 'package:flutter/material.dart';

class SymbolButton extends StatelessWidget {
  final bgcolor;
  final textcolor;
  final text;
  final click;

  //Constructor
  SymbolButton({this.bgcolor, this.textcolor, this.text, this.click});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          child: Container(
            color: bgcolor,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textcolor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
