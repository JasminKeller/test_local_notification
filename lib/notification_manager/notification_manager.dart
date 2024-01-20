import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Füge weitere benötigte Imports hier hinzu

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Konstruktor
  NotificationManager() {
    initNotification();
  }

  // Initialisierung der Benachrichtigungen
  Future<void> initNotification() async {


      notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();



    /*
    // Überprüfe und fordere gegebenenfalls Berechtigungen für Android 13+ an
    if (Platform.isAndroid && await _isAndroid13OrHigher()) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlatformChannelSpecifics =
      notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlatformChannelSpecifics != null) {
        await androidPlatformChannelSpecifics.requestPermission();
      }
    }

     */

    // Android Initialisierungseinstellungen
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('flutter_logo');

    // iOS Initialisierungseinstellungen
    DarwinInitializationSettings initializationIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        if (kDebugMode) {
          print('onDidReceiveLocalNotification called.');
        }
      },
    );

    // Allgemeine Initialisierungseinstellungen
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationIos,
    );

    // Plugin initialisieren
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) { }
    );
  }

  // Einfache Benachrichtigung anzeigen
  Future<void> simpleNotificationShow() async {
    try {
      AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'test ticker',
        showWhen: true,
        icon: 'flutter_logo',
        channelShowBadge: true,
        largeIcon: DrawableResourceAndroidBitmap('flutter_logo'),
      );

      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
      await notificationsPlugin.show(
          0,
          'Test Title',
          'Test Body',
          notificationDetails
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error showing notification: $e');
      }
    }
  }

  // Hilfsmethode zur Überprüfung der Android-Version
  Future<bool> _isAndroid13OrHigher() async {
    // Implementiere hier die Logik zur Überprüfung der Android-Version
    // Da Flutter keine direkte Methode bietet, um die Android-Version zu überprüfen,
    // musst du eine geeignete Methode finden oder eine native Android-Implementierung verwenden.
    return false;
  }
}
