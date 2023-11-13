import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theka_task/features/notifications_feature/domain/entities/notification_entities.dart';
import 'package:theka_task/features/notifications_feature/domain/use_cases/get_all_notification_usecase.dart';

part 'noti_event.dart';
part 'noti_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  static NotificationBloc get(context) => BlocProvider.of(context);
  final GetAllNotificationUsecase getAllNotificationUsecase;

  NotificationBloc({required this.getAllNotificationUsecase})
      : super(NotificationInitialState()) {
    on<NotificationEvent>((event, emit) async {
      emit(NotificationInitialState());
      final List<NotificationEntities> notificationEntities =
          await getAllNotificationUsecase();
      emit(NotificationLoadedState(notificationEntities: notificationEntities));
    });
  }
}
