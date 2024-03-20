import 'dart:math';

import 'package:flash_me/models/flashcard.dart';
import 'package:flash_me/providers/deck_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/deck.dart';

class ManualDeckBuilder extends StatelessWidget {
  ManualDeckBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NewDeckForm(),
      ),
    );
  }
}

class NewDeckForm extends ConsumerStatefulWidget {
  @override
  _NewDeckFormState createState() => _NewDeckFormState();
}

class _NewDeckFormState extends ConsumerState<NewDeckForm> {
  final TextEditingController _deckTitleController = TextEditingController();
  final TextEditingController _cardFrontController = TextEditingController();
  final TextEditingController _cardBackController = TextEditingController();

  bool _readyForSubmission = false;

  bool _displayFront = true;

  final _formKey = GlobalKey<FormState>();

  void _saveDeck(Deck deck) {
    ref.read(deckListProvider.notifier).addDeck(deck);
  }

  void _checkSubmissionState() {
    if (_cardFrontController.text.isNotEmpty &&
        _cardBackController.text.isNotEmpty) {
      _readyForSubmission = true;
    } else {
      _readyForSubmission = false;
    }
  }

  @override
  void dispose() {
    _deckTitleController.dispose();
    _cardFrontController.dispose();
    _cardBackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allDecks = ref.watch(deckListProvider);
    final allDeckTitles = allDecks.map((e) => e.title);

    final Deck deck = Deck();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _deckTitleController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Deck title...',
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a deck title.';
                }
                final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
                if (!alphanumeric.hasMatch(value)) {
                  return 'Please enter only alphanumeric characters.';
                }
                if (allDeckTitles.contains(value)) {
                  return "A deck already exist with that title.";
                }
                return null;
              },
            ),
            SizedBox(height: 30.0),
            Container(
                // key: key,
                constraints: BoxConstraints.tight(
                    Size.fromHeight(MediaQuery.of(context).size.height / 2)),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: _buildFlipAnimation()),
            SizedBox(height: 30.0),
            AnimatedOpacity(
              opacity: _readyForSubmission ? 1.0 : 0.0,
              duration:
                  Duration(milliseconds: 500), // Duration of the animation
              curve: Curves.easeInOut, // Curve for the animation
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4.0,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  fixedSize: const Size(10, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  deck.addTitle(_deckTitleController.text);

                  final cardFront = _cardFrontController.text;
                  final cardBack = _cardBackController.text;
                  deck.addCard(Flashcard(front: cardFront, back: cardBack));
                  _saveDeck(deck);
                },
                child: const Text(
                  'Save Flashcard',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() => _displayFront = !_displayFront),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeOutBack,
        child: _displayFront ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget _buildFront() {
    return __buildLayout(
        key: ValueKey(true),
        controller: _cardFrontController,
        hintText: 'Type the front of the card here...');
  }

  Widget _buildRear() {
    return __buildLayout(
        key: ValueKey(false),
        controller: _cardBackController,
        hintText: 'Type the back of the card here...');
  }

  Widget __buildLayout(
      {required Key key,
      required TextEditingController controller,
      required String hintText}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Color of the shadow
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            maxLines: 30,
            controller: controller,
            onTapOutside: (event) {
              _checkSubmissionState();
            },
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_displayFront) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
