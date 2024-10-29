// models/checklist_model.dart

class Checklist {
  final int id;
  final String checkListName;
  bool isAnswered;  // Made mutable to allow updates

  Checklist({
    required this.id,
    required this.checkListName,
    required this.isAnswered,
  });

  // Create from JSON
  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'] as int,
      checkListName: json['check_list_name'] as String,
      isAnswered: json['is_answered'] as bool,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'check_list_name': checkListName,
      'is_answered': isAnswered,
    };
  }

  // Create a copy with modified values
  Checklist copyWith({
    int? id,
    String? checkListName,
    bool? isAnswered,
  }) {
    return Checklist(
      id: id ?? this.id,
      checkListName: checkListName ?? this.checkListName,
      isAnswered: isAnswered ?? this.isAnswered,
    );
  }
}

class Complaint {
  final int id;
  final String date;
  final String complaint;
  final String? image;

  Complaint({
    required this.id,
    required this.date,
    required this.complaint,
    this.image,
  });

  // Create from JSON
  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'] as int,
      date: json['date'] as String,
      complaint: json['complaint'] as String,
      image: json['image'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'complaint': complaint,
      if (image != null) 'image': image,
    };
  }

  // Create a copy with modified values
  Complaint copyWith({
    int? id,
    String? date,
    String? complaint,
    String? image,
  }) {
    return Complaint(
      id: id ?? this.id,
      date: date ?? this.date,
      complaint: complaint ?? this.complaint,
      image: image ?? this.image,
    );
  }
}

// Response model for API responses
class ChecklistResponse {
  final bool status;
  final String message;
  final List<Checklist> checklists;
  final List<Complaint> complaints;

  ChecklistResponse({
    required this.status,
    required this.message,
    required this.checklists,
    required this.complaints,
  });

  factory ChecklistResponse.fromJson(Map<String, dynamic> json) {
    return ChecklistResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      checklists: (json['checklists'] as List)
          .map((e) => Checklist.fromJson(e as Map<String, dynamic>))
          .toList(),
      complaints: (json['complaints'] as List)
          .map((e) => Complaint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'checklists': checklists.map((e) => e.toJson()).toList(),
      'complaints': complaints.map((e) => e.toJson()).toList(),
    };
  }
}

// Request model for updating checklist
class UpdateChecklistRequest {
  final int toiletId;
  final List<Checklist> checklists;
  final List<Complaint> complaints;

  UpdateChecklistRequest({
    required this.toiletId,
    required this.checklists,
    required this.complaints,
  });

  Map<String, dynamic> toJson() {
    return {
      'toilet_id': toiletId,
      'checklists': checklists.map((e) => e.toJson()).toList(),
      'complaints': complaints.map((e) => e.toJson()).toList(),
    };
  }
}
