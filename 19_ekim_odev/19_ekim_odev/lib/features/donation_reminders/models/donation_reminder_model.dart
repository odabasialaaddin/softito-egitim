/// Bağış hatırlatma bildirimi veri modeli.
class DonationReminder {
  final String id;
  final String title;
  final String description;
  final String targetDate;
  final String bloodType;
  final bool isActive;
  final int daysLeft;

  const DonationReminder({
    required this.id,
    required this.title,
    required this.description,
    required this.targetDate,
    required this.bloodType,
    required this.isActive,
    required this.daysLeft,
  });

  DonationReminder copyWith({
    String? id,
    String? title,
    String? description,
    String? targetDate,
    String? bloodType,
    bool? isActive,
    int? daysLeft,
  }) {
    return DonationReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetDate: targetDate ?? this.targetDate,
      bloodType: bloodType ?? this.bloodType,
      isActive: isActive ?? this.isActive,
      daysLeft: daysLeft ?? this.daysLeft,
    );
  }

  factory DonationReminder.fromJson(Map<String, dynamic> json) {
    return DonationReminder(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      targetDate: json['targetDate'] as String? ?? '',
      bloodType: json['bloodType'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      daysLeft: json['daysLeft'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'targetDate': targetDate,
      'bloodType': bloodType,
      'isActive': isActive,
      'daysLeft': daysLeft,
    };
  }
}
