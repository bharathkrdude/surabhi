class ToiletModel {
  final int id;
  final String toiletCode;
  final double rating;
  final String toiletStatus;

  ToiletModel({
    required this.id,
    required this.toiletCode,
    required this.rating,
    required this.toiletStatus,
  });

  factory ToiletModel.fromJson(Map<String, dynamic> json) {
    return ToiletModel(
      id: json['id'],
      toiletCode: json['toilet_code'],
      rating: json['rating'].toDouble(),
      toiletStatus: json['toilet_status'],
    );
  }
}