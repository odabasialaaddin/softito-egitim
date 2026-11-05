import 'package:firebase_messaging/firebase_messaging.dart';
//arka planı dinleyebilmek için sınıfın üstünde olmak zorunda: pragma sayesinde. mülakatta sorabilirler pragmayı.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgrounHadler(RemouteMessage message) async{
  print("arka planda bildirim geldi: ${message.notification?.title}");
}



class BildirimServisi {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> baslat() async{
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Kullanıcı Bildirim iznini verdi");
    }

    final token = await _fcm.getToken();
    print('Cihazın FCM tokenı: $token');
  }
}