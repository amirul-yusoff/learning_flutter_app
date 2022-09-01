import 'package:flutter/material.dart';

class CustomFindDataButton extends StatelessWidget {
  CustomFindDataButton({required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.green,
      splashColor: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
              Icons.find_in_page_outlined,
              color: Colors.amber,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "Find Data",
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
