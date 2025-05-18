import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const SignButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 276,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ), // Border radius 20 yapıldı
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary, // Border rengi
              width: 1.0, // Border kalınlığı
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: textColor,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
