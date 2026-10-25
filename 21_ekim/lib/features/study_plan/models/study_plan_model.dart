class StudyPlanModel {
  final String id;
  final String day;
  final String timeSlot;
  final String subject;
  final String goal;
  final bool isCompleted;

  const StudyPlanModel({
    required this.id,
    required this.day,
    required this.timeSlot,
    required this.subject,
    this.goal = '',
    this.isCompleted = false,
  });

  StudyPlanModel copyWith({
    String? id,
    String? day,
    String? timeSlot,
    String? subject,
    String? goal,
    bool? isCompleted,
  }) {
    return StudyPlanModel(
      id: id ?? this.id,
      day: day ?? this.day,
      timeSlot: timeSlot ?? this.timeSlot,
      subject: subject ?? this.subject,
      goal: goal ?? this.goal,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory StudyPlanModel.fromJson(Map<String, dynamic> json) {
    return StudyPlanModel(
      id: json['id'] as String? ?? '',
      day: json['day'] as String? ?? '',
      timeSlot: json['timeSlot'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      goal: json['goal'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'timeSlot': timeSlot,
      'subject': subject,
      'goal': goal,
      'isCompleted': isCompleted,
    };
  }
}
