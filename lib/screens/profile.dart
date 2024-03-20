import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen(this.isRevealed, {super.key});

  final bool isRevealed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: isRevealed ? 0 : MediaQuery.of(context).size.height - 100,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(MediaQuery.of(context).padding.bottom),
            bottomRight:
                Radius.circular(MediaQuery.of(context).padding.bottom)),
        child: Container(
          color: Theme.of(context)
              .colorScheme
              .background, // Adjust color as needed
          child: const Center(
            child: Text(
              'Revealed Profile',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
