import 'package:flash_me/models/deck.dart';
import 'package:flash_me/providers/deck_list_notifier.dart';
import 'package:flash_me/widgets/deck_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckCarousel extends ConsumerStatefulWidget {
  const DeckCarousel({super.key, required this.decks});
  final List<Deck> decks;

  @override
  ConsumerState<DeckCarousel> createState() => _DeckCarouselState();
}

class _DeckCarouselState extends ConsumerState<DeckCarousel> {
  late PageController _pageController;
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
              itemCount: widget.decks.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: DeckCard(
                        deck: widget.decks[pagePosition],
                        onDelete: (deck) {
                          setState(() {
                            ref
                                .read(deckListProvider.notifier)
                                .removeDeck(deck);
                          });
                        }));
              }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(widget.decks.length, activePage))
      ],
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
