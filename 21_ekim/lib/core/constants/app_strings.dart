class AppStrings {
  AppStrings._();

  // Genel Başlıklar
  static const String appTitle = 'Ders Programı Düzenleyici';
  static const String academicPlatform = 'Akademik Planlama ve İletişim Sistemi';

  // Atatürk Köşesi
  static const String ataturkQuote = 'Hayatta en hakiki mürşit ilimdir.';
  static const String ataturkSignature = 'K. Atatürk';

  // Giriş ve Kimlik Doğrulama
  static const String loginTitle = 'Giriş Yap';
  static const String registerTitle = 'Kayıt Ol';
  static const String forgotPasswordTitle = 'Şifremi Unuttum';
  static const String defaultUserId = 'user';
  static const String defaultUserPassword = '123456';
  static const String usernameOrId = 'Kullanıcı Adı veya ID';
  static const String password = 'Şifre';
  static const String passwordConfirm = 'Şifre Tekrar';
  static const String fullName = 'Ad Soyad';
  static const String email = 'E-posta';
  static const String roleTeacher = 'Öğretmen';
  static const String roleStudent = 'Öğrenci';
  static const String selectRole = 'Rol Seçiniz';
  static const String tempSavedMessage = 'Geçici olarak kaydedildi';
  static const String invalidCredentials = 'Hatalı ID veya Şifre! (Varsayılan: user / 123456)';
  static const String passwordsDoNotMatch = 'Şifreler birbiriyle eşleşmiyor!';
  static const String pleaseFillAllFields = 'Lütfen tüm alanları eksiksiz doldurun.';
  static const String rememberMe = 'Beni Hatırla';
  static const String sendResetEmail = 'Kurtarma E-postası Gönder';
  static const String logout = 'Çıkış Yap';

  static String forgotPasswordSent(String targetEmail) =>
      '$targetEmail mailine kurtarma e-postası gönderildi';

  // Ders Programı ve Çakışma
  static const String scheduleTitle = 'Ders Programı';
  static const String addCourse = 'Ders Ekle';
  static const String editCourse = 'Ders Düzenle';
  static const String deleteCourse = 'Ders Sil';
  static const String courseName = 'Ders Adı';
  static const String day = 'Gün';
  static const String timeSlot = 'Ders Saati';
  static const String instructor = 'Öğretmen';
  static const String classroom = 'Derslik';
  static const String conflictWarningTitle = 'Ders Çakışması Algılandı!';
  static const String conflictWarningDesc =
      'Seçtiğiniz gün ve saatte halihazırda başka bir ders kayıtlıdır.';

  // Notlar ve Duyurular
  static const String notesAndAnnouncements = 'Notlar & Duyurular';
  static const String addStudentNote = 'Kişisel Not Ekle';
  static const String addAnnouncement = 'Genel Duyuru Ekle';
  static const String studentName = 'Öğrenci Adı';
  static const String studentNumber = 'Öğrenci Numarası';
  static const String noteContent = 'Not İçeriği';
  static const String announcementTitle = 'Duyuru Başlığı';
  static const String announcementContent = 'Duyuru İçeriği';

  // Çalışma Planı
  static const String studyPlanTitle = 'Çalışma Planı';
  static const String addStudySlot = 'Çalışma Saati Ekle';
  static const String subject = 'Ders / Konu';
  static const String goal = 'Hedef';

  // To-Do
  static const String todoTitle = 'Görevler (To-Do)';
  static const String addTask = 'Yeni Görev Ekle';
  static const String taskTitle = 'Görev Başlığı';
  static const String taskDescription = 'Açıklama';

  // Sınav Takvimi
  static const String examCalendarTitle = 'Sınav Takvimi';
  static const String addExam = 'Sınav Ekle';
  static const String examDate = 'Sınav Tarihi';
  static const String examType = 'Sınav Türü';

  // İletişim
  static const String communicationTitle = 'İletişim Kanalı';
  static const String writeMessage = 'Mesajınızı yazınız...';
  static const String homeworkListCategory = 'Ödev Listesi';
  static const String personalAdviceCategory = 'Kişisel Öneri';
  static const String generalQuestionCategory = 'Genel Soru';

  // Butonlar
  static const String save = 'Kaydet';
  static const String cancel = 'İptal';
  static const String delete = 'Sil';
  static const String ok = 'Tamam';
}
