import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qas/tools/res_color.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        primaryColor: ResColors.mainColor,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      );

  static ThemeData dartTheme(BuildContext context) => ThemeData.dark(useMaterial3: true);
}
