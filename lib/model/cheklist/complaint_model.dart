class ComplaintModel {
  final int id;
  final String date;
  final String complaint;
  final String? image;

  ComplaintModel({
    required this.id,
    required this.date,
    required this.complaint,
    this.image,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      date: json['date'],
      complaint: json['complaint'],
      image: json['image'],
    );
  }
}
