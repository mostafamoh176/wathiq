import 'package:theka_task/features/notifications_feature/data/data_source/remote_data_source_noti.dart';
import 'package:theka_task/features/notifications_feature/domain/entities/notification_entities.dart';
import 'package:theka_task/features/notifications_feature/domain/repository/get_all_noti.dart';

class GetAllNotificationsRepoImpl implements GetAllNotificationRepo {
  final GetRemoteNotificationData getRemoteNotificationData;
  GetAllNotificationsRepoImpl({required this.getRemoteNotificationData});
  @override
  Future<List<NotificationEntities>> getAllNotification() async {
    return await getRemoteNotificationData.fetchAllNotification();
  }
}
