import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:flash_me/screens/manual_deck_builder.dart';
import 'package:flash_me/widgets/deck_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onCreateManually() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ManualDeckBuilder()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ExpandableFab(
        distance: 75,
        openElevation: 3.0,
        openIcon: const Icon(Icons.add),
        closeIcon: const Icon(Icons.close),
        children: [
          ActionButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          ActionButton(
            icon: const Icon(Icons.edit),
            onPressed: _onCreateManually,
          ),
        ],
      ),
    );
  }
}
