part of 'noti_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitialState extends NotificationState {}

final class NotificationLoadedState extends NotificationState {
  final List<NotificationEntities> notificationEntities;
  NotificationLoadedState({required this.notificationEntities});
}
