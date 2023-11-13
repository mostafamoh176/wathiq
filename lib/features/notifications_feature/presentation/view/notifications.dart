import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theka_task/core/widgets/custom_loading_widget.dart';
import 'package:theka_task/core/widgets/message_display_widget.dart';
import 'package:theka_task/features/notifications_feature/domain/entities/notification_entities.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;
import 'package:theka_task/features/notifications_feature/presentation/business_logic/noti_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: BlocProvider(
        create: (context) =>
            di.sl<NotificationBloc>()..add(GetAllNotification()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoadedState) {
              return _body(state.notificationEntities);
            } else if (state is NotificationInitialState) {
              return LoadingWidget();
            } else {
              return MessageDisplayWidget(message: "There is No Notifications");
            }
          },
        ),
      ),
    );
  }

  Widget _body(List<NotificationEntities> notificationEntities) {
    return notificationEntities.length == 0
        ? Center(
            child: Text("There is No Notification"),
          )
        : ListView.builder(
            itemCount: notificationEntities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notificationEntities[index].title),
                subtitle: Text(notificationEntities[index].body),
                trailing: Text(
                  '${notificationEntities[index].timestamp}',
                ),
              );
            },
          );
  }
}
