import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';
import 'package:theka_task/features/notifications_feature/domain/entities/notification_entities.dart';
import 'package:theka_task/features/notifications_feature/domain/repository/get_all_noti.dart';
import 'package:theka_task/features/notifications_feature/domain/repository/get_all_noti.dart';

class GetAllNotificationUsecase {
  final GetAllNotificationRepo getAllNotificationRepo;
  GetAllNotificationUsecase({required this.getAllNotificationRepo});

  Future<List<NotificationEntities>> call() async {
    return await getAllNotificationRepo.getAllNotification();
  }
}
