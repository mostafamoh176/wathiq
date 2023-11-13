import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/features/cart/data/model/cart_model.dart';
import 'package:theka_task/features/notifications_feature/data/model/notification_model.dart';

abstract class GetRemoteNotificationData {
  Future<List<NotificationModel>> fetchAllNotification();
}

class GetAllRemoteDataNotificationImpl implements GetRemoteNotificationData {
  @override
  Future<List<NotificationModel>> fetchAllNotification() async {
    try {
      CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('notifications');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();

      List<NotificationModel> notificationdList =
          querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return NotificationModel.fromJson(doc.data()!);
      }).toList();

      return notificationdList;
    } catch (e) {
      print('Error fetching data: $e');
      throw ServerException();
    }
  }
}
