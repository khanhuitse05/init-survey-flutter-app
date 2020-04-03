import 'package:flutter/material.dart';

class MyCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(70),
              offset: Offset(1.0, 4.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Icon(
          Icons.close,
          color: Colors.black45,
        ),
      ),
    );
  }
}
