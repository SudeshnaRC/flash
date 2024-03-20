import 'package:flash_me/models/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deckListProvider = StateNotifierProvider<DeckListNotifier, List<Deck>>(
    (ref) => DeckListNotifier());

class DeckListNotifier extends StateNotifier<List<Deck>> {
  DeckListNotifier() : super(const []);

  void addDeck(Deck deck) {
    removeDeckById(deck.id);
    state = [...state, deck];
  }

  void removeDeck(Deck deck) {
    state = List.from(state)..remove(deck);
  }

  void removeDeckById(String deckId) {
    state = state.where((deck) => deck.id != deckId).toList();
  }

  List<Deck> getAllDecks() {
    return [...state];
  }
}
