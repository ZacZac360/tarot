import 'package:flutter/material.dart';
import '../services/tarot_api_service.dart';
import '../widgets/card_display.dart';

class SearchCardScreen extends StatefulWidget {
  const SearchCardScreen({super.key}); // Add a constructor with super.key

  @override
  _SearchCardScreenState createState() => _SearchCardScreenState();
}

class _SearchCardScreenState extends State<SearchCardScreen> {
  final TarotAPIService apiService = TarotAPIService();
  final TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? searchedCard;
  String? errorMessage;

  void searchCard() async {
    setState(() {
      searchedCard = null;
      errorMessage = null;
    });

    try {
      final result = await apiService.searchCardByName(searchController.text);
      if (result != null) {
        setState(() {
          searchedCard = result;
        });
      } else {
        setState(() {
          errorMessage = 'No card found for "${searchController.text}"';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error searching for card: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter card name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchCard,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            if (searchedCard != null)
              Expanded(
                child: SingleChildScrollView(
                  child: CardDisplay(card: searchedCard!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
