import 'dart:convert';
import 'package:http/http.dart' as http;

class TarotAPIService {
  final String baseUrl = 'https://tarotapi.dev/api/v1';

  // Fetch all cards (if needed)
  Future<List<dynamic>> getAllCards() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cards'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('cards')) {
          return responseData['cards']; // Extract the list of cards
        } else {
          throw Exception('Unexpected response format: missing "cards" key.');
        }
      } else {
        throw Exception('API returned status code ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching cards: $e');
    }
  }

  // Fetch random cards
  Future<List<dynamic>> getRandomCards({int count = 1}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cards/random?n=$count'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('cards')) {
          return responseData['cards'] as List<dynamic>; // Return only the list of cards
        } else {
          throw Exception('Unexpected response format: "cards" key not found.');
        }
      } else {
        throw Exception('API returned status code ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching random cards: $e');
    }
  }
  // Search for cards
  Future<List<dynamic>> searchCards(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cards/search?q=$query'));
      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');  // Log the raw response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('cards')) {
          return responseData['cards']; // Return the list of cards
        } else {
          throw Exception('API response missing "cards" key.');
        }
      } else {
        throw Exception('Failed to search cards: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching cards: $e');
    }
  }



  // Get a specific card by its short name
  Future<Map<String, dynamic>?> searchCardByName(String cardName) async {
    try {
      // Format the query to remove spaces and lowercase it for consistency
      final formattedName = cardName.trim().toLowerCase();
      final response = await http.get(Uri.parse('$baseUrl/cards/search?name=$formattedName'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('cards') && responseData['cards'].isNotEmpty) {
          // Assuming the API returns a list of matching cards
          return responseData['cards'][0]; // Return the first match
        } else {
          return null; // No cards found
        }
      } else {
        throw Exception('API returned status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching for card: $e');
    }
  }

}
