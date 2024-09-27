class ChecklistModel {
  final int id;
  final String checkListName;
  bool isAnswered;

  ChecklistModel({
    required this.id,
    required this.checkListName,
    required this.isAnswered,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json['id'],
      checkListName: json['check_list_name'],
      isAnswered: json['is_answered'],
    );
  }
}
