### skills.md
```markdown
name: flutter-feature-scaffold
description: Flutter projelerinde feature bazlı kod yazmak için gerekli klasör yapısını oluşturur. ValueNotifier state mimarisini, UI ayrımını, rol bazlı yetkilendirmeyi ve birim test iskeletini standartlara uygun olarak üretir.

# Flutter Feature Scaffold (Modüler Ekran İskeleti)
Bu yetenek, **Ders Programı Düzenleyici** projesinde yeni bir ekran ya da işlev modülü (`auth`, `schedule`, `study_plan`, `todo`, `exam_calendar`, `communication`) açarken Clean UI, 40 satır `build` sınırı ve reaktif `ValueNotifier` state kurallarına tam uyulmasını garanti altına alır.

## Temel Kurallar
1. **Asla Tek Dosyada Toplama:** UI (`_view.dart`), State Controller (`_controller.dart`), Model (`_model.dart`) ve alt bileşen (`widget/`) dosyaları ayrı ayrı açılmalıdır.
2. **State Yönetimi:** Basit ve reaktif durumlar için `ValueNotifier` ve `ValueListenableBuilder` kullanılmalıdır. Doğrudan devasa `StatefulWidget` yazarak işi karmaşıklaştırma.
3. **`const` Zorunluluğu:** Mümkün olan tüm widget'larda ve model kurucularında `const` olmalıdır.
4. **40 Satır Kuralı:** `build` metotları 40 satırı geçemez; alt parçalar `widget/` klasörüne taşınmalıdır.

---

## Adım Adım Uygulama Akışı

### Adım 1: Klasör Yapısını Oluşturma
Hedeflenen modül adlarını (örn: `schedule`, `todo`, `exam_calendar`), `lib/features/<feature_name>` altına kur:

```text
lib/features/<feature_name>/
    controller/
        <feature_name>_controller.dart
    models/
        <feature_name>_model.dart
    view/
        <feature_name>_view.dart
    widget/
        <feature_name>_card.dart
Adım 2: Controller Dosyasını Yaz (ValueNotifier & İş Mantığı)
controller/<feature_name>_controller.dart içinde mantığı ve ValueNotifier tanımlarını oluştur. (Örnek: Ders Çakışma Kontrolü içeren ScheduleController):
Dart
import 'package:flutter/foundation.dart';
import '../models/course_model.dart';

class ScheduleController {
  final ValueNotifier<List<CourseModel>> courses = ValueNotifier<List<CourseModel>>([]);
  final ValueNotifier<String?> conflictError = ValueNotifier<String?>(null);

  bool addCourse(CourseModel newCourse) {
    final hasConflict = courses.value.any(
      (course) => course.day == newCourse.day && course.timeSlot == newCourse.timeSlot,
    );

    if (hasConflict) {
      conflictError.value = '${newCourse.day} günü ${newCourse.timeSlot} saatinde başka bir ders var!';
      return false;
    }

    conflictError.value = null;
    courses.value = [...courses.value, newCourse];
    return true;
  }

  void removeCourse(String id) {
    courses.value = courses.value.where((c) => c.id != id).toList();
  }

  void dispose() {
    courses.dispose();
    conflictError.dispose();
  }
}
Adım 3: Model Dosyasını Oluşturma (immutable, copyWith, fromJson, toJson)
models/<feature_name>_model.dart dosyasını copyWith, fromJson, toJson metotlarını içerecek şekilde immutable olarak tanımla:
Dart
class CourseModel {
  final String id;
  final String title;
  final String day;
  final String timeSlot;

  const CourseModel({
    required this.id,
    required this.title,
    required this.day,
    required this.timeSlot,
  });

  CourseModel copyWith({
    String? id,
    String? title,
    String? day,
    String? timeSlot,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      day: day ?? this.day,
      timeSlot: timeSlot ?? this.timeSlot,
    );
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      day: json['day'] ?? '',
      timeSlot: json['timeSlot'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'day': day,
      'timeSlot': timeSlot,
    };
  }
}
Adım 4: View Dosyasını Oluşturma (StatelessWidget & Maksimum 40 Satır build)
view/<feature_name>_view.dart dosyasını StatelessWidget olarak tasarla ve ValueListenableBuilder ile dinle:
Dart
import 'package:flutter/material.dart';
import '../controller/schedule_controller.dart';
import '../widget/course_card.dart';

class ScheduleView extends StatelessWidget {
  final ScheduleController controller;
  final bool isTeacher;

  const ScheduleView({
    super.key,
    required this.controller,
    required this.isTeacher,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ders Programı')),
      body: ValueListenableBuilder(
        valueListenable: controller.courses,
        builder: (context, courseList, _) {
          return ListView.builder(
            itemCount: courseList.length,
            itemBuilder: (context, index) => CourseCard(
              course: courseList[index],
              canEdit: isTeacher,
              onDelete: () => controller.removeCourse(courseList[index].id),
            ),
          );
        },
      ),
    );
  }
}
Adım 5: Widget Dosyasını Oluşturma (Gökyüzü Mavisi Kart Tasarımı)
widget/<feature_name>_card.dart dosyasında StatelessWidget kullanarak UI katmanını oluştur:
Dart
import 'package:flutter/material.dart';
import '../models/course_model.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final bool canEdit;
  final VoidCallback onDelete;

  const CourseCard({
    super.key,
    required this.course,
    required this.canEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(course.title),
        subtitle: Text('${course.day} - ${course.timeSlot}'),
        trailing: canEdit
            ? IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}
Adım 6: Clean Architecture Kurallarına Uyum
Separation of Concerns: Her dosyanın belirli bir sorumluluğu olduğundan emin ol.
Reusability: Widget'ları ve controller'ı diğer ekranlarda da kullanabilecek şekilde tasarla.
Testability: Her katman için ayrı testler yazabileceğinden emin ol.
SSS
Soru: Hangi durumlarda bu yeteneği kullanmalıyım?
Cevap: Projede yer alan 6 ana modülü (auth, schedule, study_plan, todo, exam_calendar, communication) oluştururken bu şablonu birebir kullanmalısın.
Soru: Bu yeteneği hangi durumlarda kullanmamalıyım?
Cevap: Mevcut bir ekranı güncellerken veya küçük bir hata düzeltmesi yaparken tüm klasörleri baştan yaratmamalısın.