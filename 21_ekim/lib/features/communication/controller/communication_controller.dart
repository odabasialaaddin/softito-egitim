import 'package:flutter/foundation.dart';
import '../models/message_model.dart';
import '../../auth/models/user_model.dart';

class CommunicationController {
  CommunicationController._internal();
  static final CommunicationController instance =
      CommunicationController._internal();

  final ValueNotifier<List<MessageModel>> messages =
      ValueNotifier<List<MessageModel>>(_initialMessages);

  final ValueNotifier<String> selectedCategoryFilter =
      ValueNotifier<String>('Tümü');

  void setFilter(String category) {
    selectedCategoryFilter.value = category;
  }

  void sendMessage({
    required String content,
    required String category,
    required UserModel sender,
  }) {
    if (content.trim().isEmpty) return;

    final now = DateTime.now();
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final newMessage = MessageModel(
      id: 'm_${now.millisecondsSinceEpoch}',
      senderName: sender.name,
      senderRole: sender.role.displayName,
      content: content.trim(),
      category: category,
      timestamp: timeStr,
    );

    messages.value = [...messages.value, newMessage];
  }

  void dispose() {
    messages.dispose();
    selectedCategoryFilter.dispose();
  }

  static final List<MessageModel> _initialMessages = [
    const MessageModel(
      id: 'm1',
      senderName: 'Ahmet Öğretmen',
      senderRole: 'Öğretmen',
      content:
          'Haftalık Matematik ödev listesi: Kitabın 12. ve 13. bölümlerindeki alıştırmalar cuma gününe kadar sisteme yüklenecektir.',
      category: 'Ödev Listesi',
      timestamp: '09:15',
    ),
    const MessageModel(
      id: 'm2',
      senderName: 'Ali Öğrenci',
      senderRole: 'Öğrenci',
      content:
          'Hocam 13. bölümdeki 4. soruda kısmi integrasyon ile mi çözmemiz gerekiyor?',
      category: 'Genel Soru',
      timestamp: '10:04',
    ),
    const MessageModel(
      id: 'm3',
      senderName: 'Ahmet Öğretmen',
      senderRole: 'Öğretmen',
      content:
          'Kişisel Öneri: Ali, vize öncesi diferansiyel denklemler konularını tekrar etmen iyi olur. 4. soru için trigonometrik dönüşüm kullanabilirsin.',
      category: 'Kişisel Öneri',
      timestamp: '10:20',
    ),
  ];
}
