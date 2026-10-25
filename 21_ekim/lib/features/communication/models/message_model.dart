class MessageModel {
  final String id;
  final String senderName;
  final String senderRole;
  final String content;
  final String category;
  final String timestamp;

  const MessageModel({
    required this.id,
    required this.senderName,
    required this.senderRole,
    required this.content,
    required this.category,
    required this.timestamp,
  });

  MessageModel copyWith({
    String? id,
    String? senderName,
    String? senderRole,
    String? content,
    String? category,
    String? timestamp,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      senderRole: senderRole ?? this.senderRole,
      content: content ?? this.content,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String? ?? '',
      senderName: json['senderName'] as String? ?? '',
      senderRole: json['senderRole'] as String? ?? '',
      content: json['content'] as String? ?? '',
      category: json['category'] as String? ?? 'Genel Soru',
      timestamp: json['timestamp'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'senderRole': senderRole,
      'content': content,
      'category': category,
      'timestamp': timestamp,
    };
  }
}
