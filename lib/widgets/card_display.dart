import 'package:flutter/material.dart';

class CardDisplay extends StatelessWidget {
  final Map<String, dynamic> card;

  const CardDisplay({super.key, required this.card});

  // Determine the card orientation (Upright or Reversed)
  String getCardOrientation() {
    return (DateTime.now().microsecondsSinceEpoch % 2 == 0) ? 'Upright' : 'Reversed';
  }

  @override
  Widget build(BuildContext context) {
    final orientation = getCardOrientation();
    final meaning = orientation == 'Upright'
        ? card['meaning_up'] ?? 'No upright meaning available'
        : card['meaning_rev'] ?? 'No reversed meaning available';
    final imageUrl = card['image_url'] ?? ''; // Uncomment this when images are available

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Uncomment the following block when images are ready
            /*
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                height: 200, // Set a fixed height for the image
                fit: BoxFit.cover, // Ensure the image scales properly
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 100); // Placeholder if image fails to load
                },
              ),
            */
            const SizedBox(height: 10),
            Text(
              card['name'] ?? 'Unknown Card',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Orientation: $orientation',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(
              'Meaning: $meaning',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              card['desc'] ?? 'No description available',
              textAlign: TextAlign.justify,
            ),
            // Additional card attributes
            const SizedBox(height: 10),
            Text(
              'Keywords: ${card['keywords']?.join(', ') ?? 'No keywords available'}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: ${card['category'] ?? 'No category available'}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
