import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/paths.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => NavigationService().goBack(),
        ),
      ),
      body: Column(children: [_savedCards()]),
    );
  }

  Widget _savedCards() {
    return Container(
      child: Column(children: [
        Text(
          "Do You want Saved Card?",
          style: getLightStyle(color: Colors.black),
        ),
        Card(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.all(6),
            height: 70,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("MOSTAFA MOHAMED"),
                  Text("2543 **** **** ****"),
                  Text("15/07")
                ]),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Or Need To Add Card?",
                style: getLightStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50.h,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              NavigationService().navigateTo(Paths.CREDITCARD, "cart");
            },
            child: Text("Add New Card"),
            style: ElevatedButton.styleFrom(minimumSize: Size(300.w, 50.h)),
          ),
        )
      ]),
    );
  }
}
