class CourseModel {
  final String id;
  final String title;
  final String day;
  final String timeSlot;
  final String instructor;
  final String classroom;

  const CourseModel({
    required this.id,
    required this.title,
    required this.day,
    required this.timeSlot,
    this.instructor = '',
    this.classroom = '',
  });

  CourseModel copyWith({
    String? id,
    String? title,
    String? day,
    String? timeSlot,
    String? instructor,
    String? classroom,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      day: day ?? this.day,
      timeSlot: timeSlot ?? this.timeSlot,
      instructor: instructor ?? this.instructor,
      classroom: classroom ?? this.classroom,
    );
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      day: json['day'] as String? ?? '',
      timeSlot: json['timeSlot'] as String? ?? '',
      instructor: json['instructor'] as String? ?? '',
      classroom: json['classroom'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'day': day,
      'timeSlot': timeSlot,
      'instructor': instructor,
      'classroom': classroom,
    };
  }
}
