import 'package:flash_me/models/deck.dart';
import 'package:flutter/material.dart';

class DeckCard extends StatelessWidget {
  final Deck deck;
  final Function(Deck deck) onDelete;

  const DeckCard({Key? key, required this.deck, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      child: Card(
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(deck);
            },
          ),
          // tileColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          title: Text(
            deck.title,
            style: TextStyle(fontSize: 34, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
