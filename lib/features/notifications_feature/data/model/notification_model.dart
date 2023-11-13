import 'package:theka_task/features/notifications_feature/domain/entities/notification_entities.dart';

class NotificationModel extends NotificationEntities {
  NotificationModel(
      {required super.body, required super.timestamp, required super.title});
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        body: json["body"], timestamp: json["timestamp"], title: json["title"]);
  }
}
