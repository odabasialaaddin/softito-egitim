import 'package:flutter/material.dart';
import '../controller/donation_reminders_controller.dart';
import '../models/donation_reminder_model.dart';
import '../widget/donation_eligibility_card.dart';
import '../widget/donation_reminder_card.dart';

/// Kan bağış hatırlatıcılarının ve uygunluk takviminin yönetildiği görünüm.
class DonationRemindersView extends StatelessWidget {
  final DonationRemindersController controller;

  const DonationRemindersView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.daysUntilEligibleNotifier,
      builder: (context, daysLeft, _) {
        return ValueListenableBuilder<List<DonationReminder>>(
          valueListenable: controller.remindersNotifier,
          builder: (context, reminders, _) {
            return Scaffold(
              body: _RemindersBody(
                daysLeft: daysLeft,
                reminders: reminders,
                controller: controller,
              ),
              floatingActionButton: _AddReminderFab(
                onPressed: () => _showAddReminderSheet(context),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddReminderSheet(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.viewInsetsOf(ctx).bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yeni Hatırlatıcı Ekle',
              style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Hatırlatıcı Başlığı',
                prefixIcon: Icon(Icons.title_rounded, size: 20),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Açıklama',
                prefixIcon: Icon(Icons.notes_rounded, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  if (title.isNotEmpty) {
                    controller.addReminder(
                      DonationReminder(
                        id: 'rem-${DateTime.now().millisecondsSinceEpoch}',
                        title: title,
                        description: descController.text.trim().isEmpty
                            ? 'Planlanmış bağış hatırlatması'
                            : descController.text.trim(),
                        targetDate: '30 gün sonra',
                        bloodType: '0 Rh+',
                        isActive: true,
                        daysLeft: 30,
                      ),
                    );
                    Navigator.of(ctx).pop();
                  }
                },
                child: const Text('Hatırlatıcıyı Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemindersBody extends StatelessWidget {
  final int daysLeft;
  final List<DonationReminder> reminders;
  final DonationRemindersController controller;

  const _RemindersBody({
    required this.daysLeft,
    required this.reminders,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DonationEligibilityCard(daysLeft: daysLeft),
          const SizedBox(height: 20),
          Text(
            'Kurulu Hatırlatmalar & Uyarılar',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          _RemindersList(
            reminders: reminders,
            onToggle: controller.toggleReminder,
            onDelete: controller.deleteReminder,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _RemindersList extends StatelessWidget {
  final List<DonationReminder> reminders;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onDelete;

  const _RemindersList({
    required this.reminders,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Kurulu hatırlatıcı bulunmamaktadır.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      );
    }

    return Column(
      children: reminders
          .map(
            (reminder) => DonationReminderCard(
              reminder: reminder,
              onToggle: (_) => onToggle(reminder.id),
              onDelete: () => onDelete(reminder.id),
            ),
          )
          .toList(),
    );
  }
}

class _AddReminderFab extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddReminderFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.notification_add_rounded),
      label: const Text('Hatırlatıcı Kur'),
    );
  }
}
