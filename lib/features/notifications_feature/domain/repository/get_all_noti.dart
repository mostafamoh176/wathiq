import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/notifications_feature/domain/entities/notification_entities.dart';

abstract class GetAllNotificationRepo {
  Future<List<NotificationEntities>> getAllNotification();
}
