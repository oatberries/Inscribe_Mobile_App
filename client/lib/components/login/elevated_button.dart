import 'package:flutter/material.dart';

class ElevatedButtonWithoutIcon extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  ElevatedButtonWithoutIcon({required this.labelText, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 50,
        width: 300,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            labelText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          ),
        
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8)
            
            ),
            backgroundColor:const Color.fromRGBO(82,183,136,1),
         
         ),
        ),
      )
    );
  }
}