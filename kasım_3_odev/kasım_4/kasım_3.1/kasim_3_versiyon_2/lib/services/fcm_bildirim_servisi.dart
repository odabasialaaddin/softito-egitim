import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm: entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {}

class FcmBildirimServisi {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> baslat ({
    required Function(RemoteMessage message) onMesajGeldi,
  }) async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localPlugin.initalize(initSettings);
    FirebaseMessaging.onMessage.listen((message) {
      onMesajGeldi(message);
    });

    FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
    
  }

  Future<void> konuyaAboneOl(String konu) async {
    await _fcm.subscribeToTopic(konu);
  }

  Future<void> konudanAyril(String konu) async {
    await _fcm.unsubscribeFromTopic(konu);
  }

  Future<void> _yerelBildirimGoster(RemoteMessage message) async {
    const AndroidNotificationDetails('softit_fcm_channel_id',
     'softito bildirimleri',
      channelDescription: 'Fcm Push bildirimleri',
      importance: Importance.max,
      priority: Priority.high,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      await _localPLugin.show(
        message.hashCode,
        message.notification?.title ?? 'yeni bildirim',
        message.notification?.body ?? '',
        details,
      );
  }
}
