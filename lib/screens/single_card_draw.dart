import 'package:flutter/material.dart';
import '../services/tarot_api_service.dart';
import '../widgets/card_display.dart';

class SingleCardDraw extends StatelessWidget {
  final TarotAPIService apiService = TarotAPIService();

  SingleCardDraw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single Card Draw')),
      body: FutureBuilder(
        future: apiService.getRandomCards(count: 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final card = snapshot.data![0];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: CardDisplay(card: card),
            );
          } else {
            return const Center(child: Text('No card found.'));
          }
        },
      ),
    );
  }
}
