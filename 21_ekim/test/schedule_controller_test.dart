import 'package:flutter_test/flutter_test.dart';
import 'package:ders_programi_duzenleyici/features/schedule/controller/schedule_controller.dart';
import 'package:ders_programi_duzenleyici/features/schedule/models/course_model.dart';

void main() {
  group('ScheduleController Tests', () {
    final controller = ScheduleController.instance;

    test('addCourse should detect conflict on same day and timeslot', () {
      // pazartesi 09:00 - 10:30 already exists as Matematik I
      const conflictingCourse = CourseModel(
        id: 'test_c1',
        title: 'Geometri',
        day: 'Pazartesi',
        timeSlot: '09:00 - 10:30',
      );

      final added = controller.addCourse(conflictingCourse);
      expect(added, isFalse);
      expect(controller.conflictError.value, isNotNull);
    });

    test('addCourse should succeed when no conflict', () {
      const nonConflictingCourse = CourseModel(
        id: 'test_c2',
        title: 'Kimya',
        day: 'Cuma',
        timeSlot: '14:00 - 15:30',
      );

      final added = controller.addCourse(nonConflictingCourse);
      expect(added, isTrue);
      expect(controller.conflictError.value, isNull);

      // Clean up
      controller.removeCourse('test_c2');
    });
  });
}
