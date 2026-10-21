import 'package:flutter/foundation.dart';
import '../models/study_plan_model.dart';

class StudyPlanController {
  StudyPlanController._internal();
  static final StudyPlanController instance = StudyPlanController._internal();

  final ValueNotifier<List<StudyPlanModel>> plans =
      ValueNotifier<List<StudyPlanModel>>(_initialPlans);

  void addPlan(StudyPlanModel plan) {
    plans.value = [...plans.value, plan];
  }

  void removePlan(String id) {
    plans.value = plans.value.where((p) => p.id != id).toList();
  }

  void toggleCompletion(String id) {
    plans.value = [
      for (final p in plans.value)
        if (p.id == id) p.copyWith(isCompleted: !p.isCompleted) else p,
    ];
  }

  void dispose() {
    plans.dispose();
  }

  static final List<StudyPlanModel> _initialPlans = [
    const StudyPlanModel(
      id: 'sp1',
      day: 'Pazartesi',
      timeSlot: '17:00 - 18:30',
      subject: 'Matematik Türev ve İntegral',
      goal: '50 soru çözümü ve formül tekrarı',
      isCompleted: false,
    ),
    const StudyPlanModel(
      id: 'sp2',
      day: 'Salı',
      timeSlot: '19:00 - 20:30',
      subject: 'Fizik Hareket Yasaları',
      goal: 'Konu özeti ve laboratuvar soruları',
      isCompleted: true,
    ),
    const StudyPlanModel(
      id: 'sp3',
      day: 'Çarşamba',
      timeSlot: '16:00 - 17:30',
      subject: 'Algoritma Diziler & Fonksiyonlar',
      goal: 'Dart ile 3 algoritma problemi çözümü',
      isCompleted: false,
    ),
  ];
}
