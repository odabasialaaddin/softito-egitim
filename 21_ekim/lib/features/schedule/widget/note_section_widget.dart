import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widget/app_gradient_button.dart';
import '../controller/schedule_controller.dart';
import '../models/student_note_model.dart';
import '../models/announcement_model.dart';

class NoteSectionWidget extends StatelessWidget {
  final bool isTeacher;

  const NoteSectionWidget({super.key, required this.isTeacher});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionHeader(
          title: 'Genel Duyurular',
          icon: Icons.campaign_outlined,
          showAdd: isTeacher,
          onAdd: () => _showAddAnnouncementDialog(context),
        ),
        _buildAnnouncementsList(),
        const SizedBox(height: 20),
        _SectionHeader(
          title: 'Öğrenci Kişisel Notları',
          icon: Icons.assignment_ind_outlined,
          showAdd: isTeacher,
          onAdd: () => _showAddNoteDialog(context),
        ),
        _buildNotesList(),
      ],
    );
  }

  Widget _buildAnnouncementsList() {
    return ValueListenableBuilder<List<AnnouncementModel>>(
      valueListenable: ScheduleController.instance.announcements,
      builder: (context, announcements, _) {
        if (announcements.isEmpty) {
          return const _EmptyCard(text: 'Henüz duyuru bulunmamaktadır.');
        }
        return Column(
          children: announcements
              .map((a) => _AnnouncementCard(
                    announcement: a,
                    canDelete: isTeacher,
                    onDelete: () =>
                        ScheduleController.instance.removeAnnouncement(a.id),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildNotesList() {
    return ValueListenableBuilder<List<StudentNoteModel>>(
      valueListenable: ScheduleController.instance.notes,
      builder: (context, notes, _) {
        if (notes.isEmpty) {
          return const _EmptyCard(text: 'Henüz kişisel not bulunmamaktadır.');
        }
        return Column(
          children: notes
              .map((n) => _StudentNoteCard(
                    note: n,
                    canDelete: isTeacher,
                    onDelete: () =>
                        ScheduleController.instance.removeNote(n.id),
                  ))
              .toList(),
        );
      },
    );
  }

  void _showAddAnnouncementDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.addAnnouncement),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: AppStrings.announcementTitle),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: AppStrings.announcementContent),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                ScheduleController.instance.addAnnouncement(
                  AnnouncementModel(
                    id: 'a_${DateTime.now().millisecondsSinceEpoch}',
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    date: '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                    author: 'Öğretmen',
                  ),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    final nameController = TextEditingController();
    final numberController = TextEditingController();
    final contentController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.addStudentNote),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: AppStrings.studentName),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: AppStrings.studentNumber),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contentController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: AppStrings.noteContent),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && contentController.text.isNotEmpty) {
                ScheduleController.instance.addNote(
                  StudentNoteModel(
                    id: 'n_${DateTime.now().millisecondsSinceEpoch}',
                    studentName: nameController.text.trim(),
                    studentNumber: numberController.text.trim(),
                    noteContent: contentController.text.trim(),
                    createdAt: '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                  ),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool showAdd;
  final VoidCallback onAdd;

  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.showAdd,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.earthDark, size: 22),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const Spacer(),
          if (showAdd)
            AppGradientButton(
              height: 36,
              icon: Icons.add,
              onPressed: onAdd,
              child: const Text('Ekle', style: TextStyle(fontSize: 13)),
            ),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  final bool canDelete;
  final VoidCallback onDelete;

  const _AnnouncementCard({
    required this.announcement,
    required this.canDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          announcement.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(announcement.content, style: const TextStyle(color: AppColors.textDark)),
            const SizedBox(height: 4),
            Text(
              '${announcement.author} • ${announcement.date}',
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ],
        ),
        trailing: canDelete
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}

class _StudentNoteCard extends StatelessWidget {
  final StudentNoteModel note;
  final bool canDelete;
  final VoidCallback onDelete;

  const _StudentNoteCard({
    required this.note,
    required this.canDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.earthPrimary,
          child: const Icon(Icons.person, color: AppColors.white, size: 20),
        ),
        title: Text(
          '${note.studentName} (${note.studentNumber})',
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(note.noteContent, style: const TextStyle(color: AppColors.textDark)),
            const SizedBox(height: 4),
            Text(note.createdAt, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        trailing: canDelete
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String text;

  const _EmptyCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textMuted, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
