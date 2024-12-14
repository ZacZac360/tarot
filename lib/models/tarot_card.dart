class TarotCard {
  final String name;
  final String image;
  final String meaningUp;
  final String meaningRev;

  TarotCard({
    required this.name,
    required this.image,
    required this.meaningUp,
    required this.meaningRev,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(
      name: json['name'],
      image: json['image_url'],
      meaningUp: json['meaning_up'],
      meaningRev: json['meaning_rev'],
    );
  }
}
