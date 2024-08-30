import 'package:checkpoint/themes/theme.dart';
import 'package:checkpoint/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkpoint',
      theme: ThemeData(
              useMaterial3: true,
              colorScheme: MyThemes.lightColorScheme,
              fontFamily: GoogleFonts.nunitoSans().fontFamily),
          darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: MyThemes.darkColorScheme,
              fontFamily: GoogleFonts.nunitoSans().fontFamily),
          themeMode: ThemeMode.system,
          
      home: HomePage(),
    );
  }
}
