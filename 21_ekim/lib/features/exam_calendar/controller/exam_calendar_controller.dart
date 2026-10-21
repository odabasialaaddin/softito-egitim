import 'package:flutter/foundation.dart';
import '../models/exam_model.dart';

class ExamCalendarController {
  ExamCalendarController._internal();
  static final ExamCalendarController instance =
      ExamCalendarController._internal();

  final ValueNotifier<List<ExamModel>> exams =
      ValueNotifier<List<ExamModel>>(_initialExams);

  void addExam(ExamModel exam) {
    exams.value = [...exams.value, exam];
  }

  void updateExam(ExamModel updated) {
    exams.value = [
      for (final e in exams.value)
        if (e.id == updated.id) updated else e,
    ];
  }

  void removeExam(String id) {
    exams.value = exams.value.where((e) => e.id != id).toList();
  }

  void dispose() {
    exams.dispose();
  }

  static final List<ExamModel> _initialExams = [
    const ExamModel(
      id: 'e1',
      courseName: 'Matematik I',
      examDate: '15 Kasım 2026',
      timeSlot: '10:00 - 11:30',
      classroom: 'Amfi 1',
      examType: 'Vize',
      note: 'Hesap makinesi kullanımı serbesttir.',
    ),
    const ExamModel(
      id: 'e2',
      courseName: 'Fizik I',
      examDate: '18 Kasım 2026',
      timeSlot: '13:00 - 14:30',
      classroom: 'Derslik 201',
      examType: 'Vize',
      note: 'Formül kağıdı dağıtılacaktır.',
    ),
    const ExamModel(
      id: 'e3',
      courseName: 'Algoritma ve Programlama',
      examDate: '22 Kasım 2026',
      timeSlot: '09:30 - 11:00',
      classroom: 'Bilişim Laboratuvarı A',
      examType: 'Vize',
      note: 'Uygulamalı kodlama sınavı.',
    ),
  ];
}
