import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/splash_screen.dart';

class UnitConverterApp extends StatefulWidget {
  final SharedPreferences prefs;
  UnitConverterApp({required this.prefs});

  @override
  State<UnitConverterApp> createState() => _UnitConverterAppState();
}

class _UnitConverterAppState extends State<UnitConverterApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    final stored = widget.prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = stored == 'light'
          ? ThemeMode.light
          : stored == 'dark'
          ? ThemeMode.dark
          : ThemeMode.system;
    });
  }

  void _updateTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
      widget.prefs.setString(
          'themeMode', mode == ThemeMode.light ? 'light' : mode == ThemeMode.dark ? 'dark' : 'system');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFD95E73), // soft pink like the reference
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD95E73),
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFB33A55),
        scaffoldBackgroundColor: Color(0xFF0F1115),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFB33A55),
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
        ),
      ),
      home: SplashScreen(
        prefs: widget.prefs,
        onThemeChanged: _updateTheme,

        // onFinished: () => Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (_) => HomeScreen(onThemeChanged: _updateTheme, prefs: widget.prefs)),
        // ),
      ),
    );
  }
}