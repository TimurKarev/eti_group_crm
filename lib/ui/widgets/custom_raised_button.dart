import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({this.height: 50.0, this.text, this.icon, this.onPressed});

  final String text;
  final IconData icon;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        label: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
