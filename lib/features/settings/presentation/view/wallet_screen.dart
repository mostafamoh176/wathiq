import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/paths.dart';
import 'package:theka_task/features/settings/domain/entities/card_details.dart';
import 'package:theka_task/features/settings/presentation/business_logic/bloc/setting_bloc_bloc.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;

class CreditCardScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController cvsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String data = ModalRoute.of(context)?.settings.arguments as String;

    return BlocProvider(
      create: (context) => di.sl<SettingBlocBloc>(),
      child: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _formFieldWithType(
                      type: "Name : ",
                      controller: nameController,
                      textInputType: TextInputType.name),
                  _formFieldWithType(
                      type: "Date : ",
                      controller: dateController,
                      textInputType: TextInputType.number),
                  _formFieldWithType(
                      type: "Number : ",
                      controller: numberController,
                      textInputType: TextInputType.number),
                  _formFieldWithType(
                      type: "CVS : ",
                      controller: cvsController,
                      textInputType: TextInputType.number),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<SettingBlocBloc, SettingBlocState>(
                listener: (context, state) {
                  if (state is CashingSuccessfullyState && data == "cart") {
                    Fluttertoast.showToast(
                        msg: "Card Saved Successfully",
                        timeInSecForIosWeb: 3,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorsManager.success,
                        textColor: Colors.white,
                        fontSize: 16.0.sp);
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      SettingBlocBloc.get(context).add(CahedCreditCardsEvent(
                          cardEntities: CardEntities(
                        number: int.parse(numberController.text),
                        date: int.parse(dateController.text),
                        cvs: int.parse(cvsController.text),
                        name: nameController.text,
                      )));
                      if (data == "cart") {
                        NavigationService()
                            .navigateTo(Paths.BOTTOMNAVBAR, null);
                        SettingBlocBloc.get(context).add(DeletedCardsEvent());
                        Fluttertoast.showToast(
                                msg: "congrats!!",
                                timeInSecForIosWeb: 3,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: ColorsManager.success,
                                textColor: Colors.white,
                                fontSize: 16.0.sp)
                            .then((value) => NavigationService().goBack());
                      } else {
                        NavigationService().goBack();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorsManager.black,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Text(
                        "Add Card",
                        style: getLightStyle(color: ColorsManager.white),
                      )),
                    ),
                  );
                },
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget _formFieldWithType(
      {required String type,
      required TextEditingController controller,
      required TextInputType textInputType}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        child: Row(children: [
          Expanded(
              child: Text(
            type,
            style: getEtraLightStyle(color: ColorsManager.black),
          )),
          Expanded(
              flex: 5,
              child: TextFormField(
                controller: controller,
                keyboardType: textInputType,
              ))
        ]),
      ),
    );
  }
}
