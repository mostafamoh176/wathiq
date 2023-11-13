import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class HandleNotification {
  Future<void> initNotification();
}

class HandleNotificationImpl implements HandleNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      saveNotificationInFirestore(message);
    });
  }

  Future<void> saveNotificationInFirestore(RemoteMessage message) async {
    CollectionReference<Map<String, dynamic>> notifications =
        FirebaseFirestore.instance.collection('notifications');

    await notifications.add({
      'title': message.notification?.title ?? 'No Title',
      'body': message.notification?.body ?? 'No Body',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

Future<void> handleBackgroundMessage(message) async {
  print("msg::${message.data.title}");
}
