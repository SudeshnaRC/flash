import 'package:flash_me/screens/current.dart';
import 'package:flash_me/screens/profile.dart';
import 'package:flutter/material.dart';

class AppTemplate extends StatefulWidget {
  const AppTemplate({super.key});

  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 30 && !_isRevealed) {
          setState(() {
            _isRevealed = true;
          });
        } else if (details.delta.dy < -30 && _isRevealed) {
          setState(() {
            _isRevealed = false;
          });
        }
      },
      child: Stack(
        children: [
          //Current Screen
          const CurrentScreen(),
          // Revealed Screen
          ProfileScreen(_isRevealed)
        ],
      ),
    );
  }
}
