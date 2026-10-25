class StudentNoteModel {
  final String id;
  final String studentName;
  final String studentNumber;
  final String noteContent;
  final String createdAt;

  const StudentNoteModel({
    required this.id,
    required this.studentName,
    required this.studentNumber,
    required this.noteContent,
    required this.createdAt,
  });

  StudentNoteModel copyWith({
    String? id,
    String? studentName,
    String? studentNumber,
    String? noteContent,
    String? createdAt,
  }) {
    return StudentNoteModel(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      studentNumber: studentNumber ?? this.studentNumber,
      noteContent: noteContent ?? this.noteContent,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory StudentNoteModel.fromJson(Map<String, dynamic> json) {
    return StudentNoteModel(
      id: json['id'] as String? ?? '',
      studentName: json['studentName'] as String? ?? '',
      studentNumber: json['studentNumber'] as String? ?? '',
      noteContent: json['noteContent'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentName': studentName,
      'studentNumber': studentNumber,
      'noteContent': noteContent,
      'createdAt': createdAt,
    };
  }
}
