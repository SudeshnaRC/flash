import 'package:flash_me/widgets/app_template.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theme = ThemeData(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF13B399),
        onPrimary: Colors.black,
        secondary: Color(0xFFEDEEED),
        onSecondary: Colors.black,
        error: Color(0xFFFF9502),
        onError: Colors.black,
        background: Color(0xFF13B399),
        onBackground: Colors.black,
        surface: Color(0xFFEDEEED),
        onSurface: Colors.black,
        outline: Color(0xFFD9BC7E)),
    textTheme: TextTheme(
        headlineLarge: GoogleFonts.roboto(
            fontWeight: FontWeight.w900, letterSpacing: -0.5),
        headlineMedium: GoogleFonts.roboto(
            fontWeight: FontWeight.w100, letterSpacing: -0.5),
        bodyMedium: GoogleFonts.neucha(letterSpacing: -0.5)));

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flash Me!', theme: theme, home: const AppTemplate());
  }
}
