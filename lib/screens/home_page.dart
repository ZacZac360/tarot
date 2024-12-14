import 'package:flutter/material.dart';
import 'three_card_spread.dart';
import 'single_card_draw.dart';
import 'search_cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarot Reading')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ThreeCardSpread()),
              ),
              child: const Text('Three-Card Spread'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SingleCardDraw()),
              ),
              child: const Text('Single Card Draw'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchCardScreen()),
              ),
              child: const Text('Search Cards'),
            ),
          ],
        ),
      ),
    );
  }
}
