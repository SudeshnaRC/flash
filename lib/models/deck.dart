import 'package:flash_me/models/flashcard.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Deck {
  String id;
  String title = "";
  List<Flashcard> cards = [];

  Deck() : id = uuid.v4();

  void addCard(Flashcard card) {
    cards.add(card);
  }

  void addTitle(String title) {
    this.title = title;
  }
}
