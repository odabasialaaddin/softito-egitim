import 'package:flutter/foundation.dart';
import '../models/course_model.dart';
import '../models/student_note_model.dart';
import '../models/announcement_model.dart';

class ScheduleController {
  ScheduleController._internal();
  static final ScheduleController instance = ScheduleController._internal();

  final ValueNotifier<List<CourseModel>> courses =
      ValueNotifier<List<CourseModel>>(_initialCourses);

  final ValueNotifier<List<StudentNoteModel>> notes =
      ValueNotifier<List<StudentNoteModel>>(_initialNotes);

  final ValueNotifier<List<AnnouncementModel>> announcements =
      ValueNotifier<List<AnnouncementModel>>(_initialAnnouncements);

  final ValueNotifier<String?> conflictError = ValueNotifier<String?>(null);

  bool addCourse(CourseModel newCourse) {
    final hasConflict = courses.value.any(
      (course) =>
          course.day.toLowerCase() == newCourse.day.toLowerCase() &&
          course.timeSlot == newCourse.timeSlot,
    );

    if (hasConflict) {
      conflictError.value =
          '${newCourse.day} günü ${newCourse.timeSlot} saatinde başka bir ders var! Çakışma engellendi.';
      return false;
    }

    conflictError.value = null;
    courses.value = [...courses.value, newCourse];
    return true;
  }

  void removeCourse(String id) {
    courses.value = courses.value.where((c) => c.id != id).toList();
  }

  bool updateCourse(CourseModel updated) {
    final hasConflict = courses.value.any(
      (course) =>
          course.id != updated.id &&
          course.day.toLowerCase() == updated.day.toLowerCase() &&
          course.timeSlot == updated.timeSlot,
    );

    if (hasConflict) {
      conflictError.value =
          '${updated.day} günü ${updated.timeSlot} saatinde başka bir ders var!';
      return false;
    }

    conflictError.value = null;
    courses.value = [
      for (final c in courses.value)
        if (c.id == updated.id) updated else c,
    ];
    return true;
  }

  void addNote(StudentNoteModel note) {
    notes.value = [note, ...notes.value];
  }

  void removeNote(String id) {
    notes.value = notes.value.where((n) => n.id != id).toList();
  }

  void addAnnouncement(AnnouncementModel announcement) {
    announcements.value = [announcement, ...announcements.value];
  }

  void removeAnnouncement(String id) {
    announcements.value =
        announcements.value.where((a) => a.id != id).toList();
  }

  void clearConflict() {
    conflictError.value = null;
  }

  void dispose() {
    courses.dispose();
    notes.dispose();
    announcements.dispose();
    conflictError.dispose();
  }

  static final List<CourseModel> _initialCourses = [
    const CourseModel(
      id: 'c1',
      title: 'Matematik I',
      day: 'Pazartesi',
      timeSlot: '09:00 - 10:30',
      instructor: 'Dr. Mehmet Yılmaz',
      classroom: 'Amfi 1',
    ),
    const CourseModel(
      id: 'c2',
      title: 'Fizik I',
      day: 'Pazartesi',
      timeSlot: '11:00 - 12:30',
      instructor: 'Prof. Dr. Ayşe Kaya',
      classroom: 'Lab 2',
    ),
    const CourseModel(
      id: 'c3',
      title: 'Algoritma ve Programlama',
      day: 'Salı',
      timeSlot: '13:30 - 15:00',
      instructor: 'Doç. Dr. Can Demir',
      classroom: 'Bilişim Lab',
    ),
    const CourseModel(
      id: 'c4',
      title: 'Türk Dili',
      day: 'Çarşamba',
      timeSlot: '10:00 - 11:30',
      instructor: 'Öğr. Gör. Zeynep Ak',
      classroom: 'Derslik 104',
    ),
  ];

  static final List<StudentNoteModel> _initialNotes = [
    const StudentNoteModel(
      id: 'n1',
      studentName: 'Ali Öğrenci',
      studentNumber: '2024001',
      noteContent: 'Matematik vize ödevini teslim etti. Sonuç: 90 / Çok başarılı.',
      createdAt: '21 Ekim 2026',
    ),
    const StudentNoteModel(
      id: 'n2',
      studentName: 'Zeynep Çelik',
      studentNumber: '2024015',
      noteContent: 'Fizik laboratuvar raporunda eksikler var, cuma gününe kadar revize etmeli.',
      createdAt: '20 Ekim 2026',
    ),
  ];

  static final List<AnnouncementModel> _initialAnnouncements = [
    const AnnouncementModel(
      id: 'a1',
      title: 'Matematik Vize Sınavı Hakkında',
      content: '1. Vize sınavı 15 Kasım Cuma günü Amfi 1 salonunda yapılacaktır.',
      date: '21 Ekim 2026',
      author: 'Dr. Mehmet Yılmaz',
    ),
    const AnnouncementModel(
      id: 'a2',
      title: 'Kütüphane Çalışma Saatleri',
      content: 'Vize dönemi boyunca kütüphane 7/24 hizmet verecektir.',
      date: '19 Ekim 2026',
      author: 'Rektörlük',
    ),
  ];
}
