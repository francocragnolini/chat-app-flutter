import "package:flutter/material.dart";

class BlueButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const BlueButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightElevation: 5,
      elevation: 2,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(32)),
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
