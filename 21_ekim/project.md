# Ders Programı Düzenleyici ve Akademik Platform

## 1. Proje Özeti ve Teknolojiler
- **Proje Adı:** Ders Programı Düzenleyici (Akademik Planlama, Görev ve İletişim Sistemi)
- **Hedef Platformlar:** iOS ve Android öncelikli, ardından Web ve Masaüstü platformları.
- **Flutter SDK:** 3.15.1
- **Dart SDK:** 3.6.0
- **Tasarım Dili:** Material 3, Çift Tema Desteği (`ThemeMode.system`, `ThemeMode.light`, `ThemeMode.dark`) ve Özel Kurumsal Palet (Toprak Rengi `#8D6E63`, Çim Yeşili `#4CAF50`, Gökyüzü Mavisi `#E1F5FE`).
- **Mimari Yapı:** Feature-First (Özellik Bazlı) Modüler Mimari (`controller`, `models`, `view`, `widget`).
- **State Yönetimi:** Harici paket kullanılmadan yerel `ValueNotifier<T>` ve `ValueListenableBuilder<T>`.

---

## 2. Mimari Dizin Yapısı (Feature-First)
Kodlar kesinlikle tek bir dosyada toplanmayacaktır. Her ekran ve işlev kendi `feature` klasörü altında modüler olarak kodlanacaktır:

```text
lib/
    core/
        constants/
            app_colors.dart
            app_strings.dart
        extensions/
            context_extensions.dart
        theme/
            app_theme.dart
            theme_controller.dart
            widget/
                theme_mode_switch_button.dart
    features/
        auth/
            controller/
                auth_controller.dart
            models/
                user_model.dart
            view/
                login_view.dart
                register_view.dart
                forgot_password_view.dart
            widget/
                ataturk_quote_banner.dart
                role_selector_dropdown.dart
        schedule/
            controller/
                schedule_controller.dart
            models/
                course_model.dart
                student_note_model.dart
                announcement_model.dart
            view/
                schedule_view.dart
            widget/
                course_card.dart
                conflict_alert_dialog.dart
                note_section_widget.dart
        study_plan/
            controller/
                study_plan_controller.dart
            models/
                study_plan_model.dart
            view/
                study_plan_view.dart
            widget/
                study_slot_card.dart
        todo/
            controller/
                todo_controller.dart
            models/
                todo_model.dart
            view/
                todo_view.dart
            widget/
                todo_item_tile.dart
        exam_calendar/
            controller/
                exam_calendar_controller.dart
            models/
                exam_model.dart
            view/
                exam_calendar_view.dart
            widget/
                exam_card.dart
        communication/
            controller/
                communication_controller.dart
            models/
                message_model.dart
            view/
                communication_view.dart
            widget/
                message_bubble.dart
    main.dart
3. Tasarım ve Kurumsal Renk Kuralları (core/constants/app_colors.dart)
Ana Arka Plan Rengi (scaffoldBackgroundColor): Toprak Rengi (Color(0xFF8D6E63) / Açık: Color(0xFFD7CCC8), Karanlık Mod: Koyu Toprak/Obsidian Color(0xFF2D2420))
Buton Renkleri (ElevatedButton, FloatingActionButton): Çim Yeşili (Color(0xFF4CAF50))
Kutucuk, Kart ve Input Renkleri (Card, Container, TextField): Çok Açık Gökyüzü Mavisi (Color(0xFFE1F5FE))
Atatürk Köşesi (ataturk_quote_banner.dart): Giriş ekranının en üstünde "Hayatta en hakiki mürşit ilimdir." sözü ve hemen altında "K. Atatürk" imzası yer alacaktır.
4. Modüller ve İşlevsel Gereksinimler
4.1. Auth Modülü (features/auth/)
Rol Seçimi: Öğretmen / Öğrenci seçimi açılır menü (DropdownButton) ile yapılır ve AuthController içindeki ValueNotifier<UserRole> üzerinde tutulur.
Varsayılan Giriş: Backend olmadığı için id: user ve şifre: 123456 ile doğrudan giriş yapılır.
Kayıt Ol: Rol seçimi, Ad Soyad, Mail, Şifre, Şifre Tekrar alanları bulunur. Kaydol butonuna basıldığında "Geçici olarak kaydedildi" SnackBar mesajı gösterilir ve ana sayfaya yönlendirilir.
Şifremi Unuttum: E-posta girilip butona tıklandığında "[girilen_mail] mailine kurtarma e-postası gönderildi" şeklinde SnackBar veya AlertDialog uyarısı verilir.
4.2. Ders Programı ve Notlar Modülü (features/schedule/)
Öğretmen Yetkileri:
Ders programına ders ekleyebilir, silebilir nd güncelleyebilir.
Çakışma Algılama: Yeni ders eklenirken ScheduleController içindeki listede aynı day ve timeSlot değerine sahip ders varsa işlem engellenir ve uyarı verilir.
Kişisel Öğrenci Notu: Öğrenci Adı, Öğrenci Numarası ve Not içeriği girerek özel not bırakabilir.
Genel Duyuru: Tüm öğrencilere genel duyuru yayınlayabilir.
Öğrenci Yetkileri:
Ders programını, kendisine bırakılan kişisel notları ve genel duyuruları salt okunur (read-only) olarak görüntüler.
4.3. Kendi Çalışma Planını Yarat (features/study_plan/)
Kullanıcılar Gün ve Saat seçerek kendi kişisel çalışma programlarını oluşturabilir ve silebilir.
4.4. To-Do List Görev Sayfası (features/todo/)
Görev ekleme/silme yapılır. Checkbox işaretlendiğinde TodoController üzerinden görev durumu güncellenir ve metnin üstü çizilir (TextDecoration.lineThrough).
4.5. Sınav Takvimi (features/exam_calendar/)
Öğretmen: Sınav ekleyebilir, düzenleyebilir ve silebilir.
Öğrenci: Sınav takvimini sadece görüntüler (düzenleme butonları gizlenir).
4.6. İletişim Kanalı (features/communication/)
Öğrenci ve öğretmen arasında ödev listesi ve kişisel önerilerin konuşulduğu mesajlaşma ekranıdır.
5. Veri Modelleri Standartları
Tüm modeller immutable (const kuruculu, final alanlı) olacak ve copyWith, fromJson, toJson metotlarını barındıracaktır