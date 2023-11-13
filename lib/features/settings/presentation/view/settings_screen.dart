import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/paths.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () =>
                  NavigationService().navigateTo(Paths.CREDITCARD, null),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorsManager.grey),
                    color: ColorsManager.lightGrey.withOpacity(0.2)),
                child: Center(
                  child: Text(
                    "Add New Wallet",
                    style: getLightStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
