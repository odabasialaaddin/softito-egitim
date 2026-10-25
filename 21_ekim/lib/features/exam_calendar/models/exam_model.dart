class ExamModel {
  final String id;
  final String courseName;
  final String examDate;
  final String timeSlot;
  final String classroom;
  final String examType;
  final String note;

  const ExamModel({
    required this.id,
    required this.courseName,
    required this.examDate,
    required this.timeSlot,
    required this.classroom,
    this.examType = 'Vize',
    this.note = '',
  });

  ExamModel copyWith({
    String? id,
    String? courseName,
    String? examDate,
    String? timeSlot,
    String? classroom,
    String? examType,
    String? note,
  }) {
    return ExamModel(
      id: id ?? this.id,
      courseName: courseName ?? this.courseName,
      examDate: examDate ?? this.examDate,
      timeSlot: timeSlot ?? this.timeSlot,
      classroom: classroom ?? this.classroom,
      examType: examType ?? this.examType,
      note: note ?? this.note,
    );
  }

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] as String? ?? '',
      courseName: json['courseName'] as String? ?? '',
      examDate: json['examDate'] as String? ?? '',
      timeSlot: json['timeSlot'] as String? ?? '',
      classroom: json['classroom'] as String? ?? '',
      examType: json['examType'] as String? ?? 'Vize',
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseName': courseName,
      'examDate': examDate,
      'timeSlot': timeSlot,
      'classroom': classroom,
      'examType': examType,
      'note': note,
    };
  }
}
