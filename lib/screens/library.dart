import 'package:flash_me/models/deck.dart';
import 'package:flash_me/providers/deck_list_notifier.dart';
import 'package:flash_me/widgets/deck_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(deckListProvider);

    return Scaffold(body: DeckCarousel(decks: decks));
  }
}
