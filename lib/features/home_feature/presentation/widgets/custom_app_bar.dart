import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/paths.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double actionButtonHeight;

  const MyAppBar({required this.actionButtonHeight});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationService().navigateTo(Paths.NOTIFICATIONS, null),
      child: SizedBox(
        height:
            kToolbarHeight + actionButtonHeight, // Total height of the AppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: actionButtonHeight,
              width: 50.w,
              child: Center(
                child: Stack(
                  children: [
                    const FaIcon(FontAwesomeIcons.bell),
                    Positioned(
                      left: 5.w,
                      bottom: 6.h,
                      child: CircleAvatar(
                        radius: 5.r,
                        backgroundColor: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + actionButtonHeight);
}
