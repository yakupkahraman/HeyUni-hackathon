import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final Color backgroundColor;
  final Color textColor;
  final Color hintTextColor;
  final TextEditingController controller;
  final int maxLines;
  final bool isPassword;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.backgroundColor,
    required this.textColor,
    required this.hintTextColor,
    required this.controller,
    this.maxLines = 1,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340, // TextField genişliği
      decoration: BoxDecoration(
        color: backgroundColor, // Arka plan rengi
        borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlama
        border: Border.all(
          color: Theme.of(context).colorScheme.primary, // Border rengi
          width: 2.0, // Border kalınlığı
        ),
      ),
      child: TextField(
        obscureText: isPassword,
        maxLines: maxLines,
        controller: controller, // Controller burada kullanılıyor
        style: TextStyle(
          color: textColor, // Yazı rengi
        ),
        decoration: InputDecoration(
          hintText: hintText, // Hint metni
          hintStyle: TextStyle(
            color: hintTextColor, // Hint metni rengi
          ),
          border: InputBorder.none, // Varsayılan border'ı kaldır
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ), // İçerik boşluğu
        ),
      ),
    );
  }
}
