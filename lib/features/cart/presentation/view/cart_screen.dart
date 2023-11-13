import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/paths.dart';
import 'package:theka_task/core/widgets/custom_loading_widget.dart';
import 'package:theka_task/core/widgets/message_display_widget.dart';
import 'package:theka_task/features/cart/presentation/business_logic/cart_bloc.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CartBloc>()..add(GetEventCart()),
      child: Scaffold(
        body: _productcardCheckout(),
      ),
    );
  }

  _productcardCheckout() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return LoadingWidget();
        } else if (state is CartLoadedState) {
          double totalPrice = 0;
          for (var element in state.cartEntities) {
            totalPrice =
                (double.parse(element.price) * element.number.toDouble()) +
                    totalPrice;
          }
          if (state.cartEntities.isNotEmpty) {
            return Column(
              children: [
                Container(
                  height: 380.h,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                color:
                                    ColorsManager.lightGrey.withOpacity(0.2)),
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: state.cartEntities[index].image,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.cartEntities[index].name,
                                      style: getLightStyle(
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${state.cartEntities[index].price} \$",
                                      style: getLightStyle(color: Colors.black),
                                    ),
                                    Text(
                                        "${state.cartEntities[index].number.toString()} Items",
                                        style: getLightStyle(
                                            color: ColorsManager.black))
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      },
                      itemCount: state.cartEntities.length),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Divider(
                  height: 2,
                  thickness: 5,
                  color: ColorsManager.black,
                  indent: 20.w,
                  endIndent: 20.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total Price:",
                      style: getRegularStyle(color: Colors.black),
                    ),
                    Text(
                      "${totalPrice.toString()} \$",
                      style: getRegularStyle(color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                _checkoutButton()
              ],
            );
          } else {
            Center(
              child: Text("There is No Product"),
            );
          }
        } else if (state is CartErrorState) {
          return MessageDisplayWidget(message: state.errorMsg);
        }
        return SizedBox();
      },
    );
  }

  _checkoutButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50.h),
            backgroundColor: ColorsManager.accent),
        onPressed: () => NavigationService().navigateTo(Paths.CHECKOUT, null),
        child: Text(
          "Order Now",
          style: getLightStyle(color: ColorsManager.white),
        ),
      ),
    );
  }
}
