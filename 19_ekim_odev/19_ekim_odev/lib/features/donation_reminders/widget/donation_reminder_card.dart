import 'package:flutter/material.dart';
import '../models/donation_reminder_model.dart';

/// Tek bir bağış hatırlatma kartı.
class DonationReminderCard extends StatelessWidget {
  final DonationReminder reminder;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  const DonationReminderCard({
    super.key,
    required this.reminder,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ReminderCardTop(
              reminder: reminder,
              onToggle: onToggle,
            ),
            const SizedBox(height: 8),
            _ReminderDescription(description: reminder.description),
            const SizedBox(height: 12),
            _ReminderFooter(
              targetDate: reminder.targetDate,
              daysLeft: reminder.daysLeft,
              onDelete: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderCardTop extends StatelessWidget {
  final DonationReminder reminder;
  final ValueChanged<bool> onToggle;

  const _ReminderCardTop({required this.reminder, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                size: 20,
                color: reminder.isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  reminder.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: reminder.isActive,
          onChanged: onToggle,
        ),
      ],
    );
  }
}

class _ReminderDescription extends StatelessWidget {
  final String description;

  const _ReminderDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

class _ReminderFooter extends StatelessWidget {
  final String targetDate;
  final int daysLeft;
  final VoidCallback onDelete;

  const _ReminderFooter({
    required this.targetDate,
    required this.daysLeft,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _DaysLeftBadge(daysLeft: daysLeft),
            const SizedBox(width: 8),
            Text(
              targetDate,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline_rounded, size: 18),
          visualDensity: VisualDensity.compact,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          onPressed: onDelete,
        ),
      ],
    );
  }
}

class _DaysLeftBadge extends StatelessWidget {
  final int daysLeft;

  const _DaysLeftBadge({required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$daysLeft gün kaldı',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: colorScheme.secondary,
        ),
      ),
    );
  }
}
