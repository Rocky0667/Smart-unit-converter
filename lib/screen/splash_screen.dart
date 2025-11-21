import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_converter/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final Function(ThemeMode) onThemeChanged;

  SplashScreen({required this.prefs, required this.onThemeChanged});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeInOut);
    _anim.forward();

    // Navigate *inside* splash screen context
    Timer(Duration(milliseconds: 1700), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              HomeScreen(onThemeChanged: widget.onThemeChanged, prefs: widget.prefs),
        ),
      );
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/splash_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 22),
              Text('Unit Converter',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text('All In One Universal Unit Converter',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}