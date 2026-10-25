import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/widget/theme_mode_switch_button.dart';
import '../../../core/widget/app_nav_drawer.dart';
import '../../../core/widget/role_header_badge.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/models/user_model.dart';
import '../controller/communication_controller.dart';
import '../models/message_model.dart';
import '../widget/message_bubble.dart';

class CommunicationView extends StatefulWidget {
  const CommunicationView({super.key});

  @override
  State<CommunicationView> createState() => _CommunicationViewState();
}

class _CommunicationViewState extends State<CommunicationView> {
  final TextEditingController _textController = TextEditingController();
  String _selectedCategory = AppStrings.homeworkListCategory;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.currentUser.value ??
        const UserModel(
          id: 'user',
          name: 'Kullanıcı',
          email: 'user@okul.k12.tr',
          role: UserRole.student,
        );

    return Scaffold(
      drawer: const AppNavDrawer(currentRoute: 'communication'),
      appBar: AppBar(
        title: const Text(AppStrings.communicationTitle),
        actions: const [ThemeModeSwitchButton()],
      ),
      body: Column(
        children: [
          const RoleHeaderBadge(),
          _buildFilterBar(),
          Expanded(child: _buildMessagesList(user)),
          _buildInputBar(user),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final categories = [
      'Tümü',
      AppStrings.homeworkListCategory,
      AppStrings.personalAdviceCategory,
      AppStrings.generalQuestionCategory,
    ];

    return ValueListenableBuilder<String>(
      valueListenable: CommunicationController.instance.selectedCategoryFilter,
      builder: (context, currentFilter, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: categories.map((cat) {
              final isSelected = currentFilter == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  selectedColor: AppColors.blueGradientStart,
                  backgroundColor: AppColors.skyBlueLight,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.textDark,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (_) =>
                      CommunicationController.instance.setFilter(cat),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMessagesList(UserModel user) {
    return ValueListenableBuilder<String>(
      valueListenable: CommunicationController.instance.selectedCategoryFilter,
      builder: (context, filter, _) {
        return ValueListenableBuilder<List<MessageModel>>(
          valueListenable: CommunicationController.instance.messages,
          builder: (context, allMessages, _) {
            final filtered = filter == 'Tümü'
                ? allMessages
                : allMessages.where((m) => m.category == filter).toList();

            if (filtered.isEmpty) {
              return const Center(
                child: Text(
                  'Bu kategoride mesaj bulunmamaktadır.',
                  style: TextStyle(color: AppColors.textDark),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final message = filtered[index];
                final isMine = message.senderName == user.name;
                return MessageBubble(message: message, isMine: isMine);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildInputBar(UserModel user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.creamBackground,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -1)),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildCategorySelector(),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: AppStrings.writeMessage,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                onSubmitted: (_) => _handleSend(user),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send, color: AppColors.blueGradientStart),
              onPressed: () => _handleSend(user),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return DropdownButton<String>(
      value: _selectedCategory,
      dropdownColor: AppColors.skyBlueLight,
      underline: const SizedBox.shrink(),
      icon: const Icon(Icons.label_outline, color: AppColors.earthDark),
      items: const [
        DropdownMenuItem(
          value: AppStrings.homeworkListCategory,
          child: Text(AppStrings.homeworkListCategory, style: TextStyle(fontSize: 12)),
        ),
        DropdownMenuItem(
          value: AppStrings.personalAdviceCategory,
          child: Text(AppStrings.personalAdviceCategory, style: TextStyle(fontSize: 12)),
        ),
        DropdownMenuItem(
          value: AppStrings.generalQuestionCategory,
          child: Text(AppStrings.generalQuestionCategory, style: TextStyle(fontSize: 12)),
        ),
      ],
      onChanged: (val) {
        if (val != null) setState(() => _selectedCategory = val);
      },
    );
  }

  void _handleSend(UserModel user) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    CommunicationController.instance.sendMessage(
      content: text,
      category: _selectedCategory,
      sender: user,
    );
    _textController.clear();
  }
}
