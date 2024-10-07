class Toilet {
  final int id;
  final String toiletCode;
  final double rating;
  final String toiletStatus;

  Toilet({
    required this.id,
    required this.toiletCode,
    required this.rating,
    required this.toiletStatus,
  });

  factory Toilet.fromJson(Map<String, dynamic> json) {
    return Toilet(
      id: json['id'],
      toiletCode: json['toilet_code'],
      rating: json['rating'].toDouble(),
      toiletStatus: json['toilet_status'],
    );
  }
}
