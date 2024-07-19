import 'package:flutter/material.dart';

class ListViewProfileButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;
  final String displayText;
  ListViewProfileButtons({required this.onPressed, required this.labelText, required this.displayText, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onPressed,

      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1
            ),
            // top: BorderSide(
            //   width: 1
            // ),
          )
        ),
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                displayText,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}