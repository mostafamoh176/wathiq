part of 'noti_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotification extends NotificationEvent {
  const GetAllNotification();
  @override
  List<Object> get props => [];
}
