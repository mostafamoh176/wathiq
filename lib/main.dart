import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;
import 'package:theka_task/core/util/dio_helper.dart';
import 'package:theka_task/core/util/handle_notification.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/routes.dart';
import 'package:theka_task/core/util/theme.dart';
import 'package:theka_task/features/bottom_nav_bar_feature/presentation/view/bottom_nav_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  await HandleNotificationImpl().initNotification();
  await DioHelper.init();

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  NavigationService navigationService = NavigationService();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          routes: Routes().routes,
          theme: appTheme,
          home: child,
        );
      },
      child: const BottomNavBarView(),
    );
  }
}
