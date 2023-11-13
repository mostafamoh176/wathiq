import 'package:equatable/equatable.dart';

class NotificationEntities extends Equatable {
  final String title;
  final String body;
  final String timestamp;

  NotificationEntities(
      {required this.body, required this.timestamp, required this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [title, body, timestamp];
}
