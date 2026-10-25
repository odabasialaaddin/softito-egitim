class AnnouncementModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final String author;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
  });

  AnnouncementModel copyWith({
    String? id,
    String? title,
    String? content,
    String? date,
    String? author,
  }) {
    return AnnouncementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      author: author ?? this.author,
    );
  }

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      date: json['date'] as String? ?? '',
      author: json['author'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'author': author,
    };
  }
}
