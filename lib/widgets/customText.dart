import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final bool isBold;
  const CustomText(this.text, this.fontSize, this.color, this.isBold,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: GoogleFonts.sairaCondensed(
          color: color,
          fontSize: fontSize,
          fontWeight: isBold? FontWeight.bold:FontWeight.normal,

        ),
      ),
    );
  }
}
