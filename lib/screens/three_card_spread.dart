import 'package:flutter/material.dart';
import '../services/tarot_api_service.dart';
import '../widgets/card_display.dart';

class ThreeCardSpread extends StatelessWidget {
  final TarotAPIService apiService = TarotAPIService();

  ThreeCardSpread({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Three-Card Spread')),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.getRandomCards(count: 3),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cards available.'));
          } else {
            final cards = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: cards.map((card) => CardDisplay(card: card)).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
