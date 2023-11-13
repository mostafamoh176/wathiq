import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/widgets/custom_loading_widget.dart';
import 'package:theka_task/core/widgets/message_display_widget.dart';
import 'package:theka_task/features/favorites/presentation/business_logic/fav_bloc.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<FavBloc>()..add(GetEventFav()),
      child: Scaffold(
        body: _productFavoriteCheckout(),
      ),
    );
  }

  _productFavoriteCheckout() {
    return BlocBuilder<FavBloc, FavState>(
      builder: (context, state) {
        if (state is FavLoadingState) {
          return LoadingWidget();
        } else if (state is FavLoadedState) {
          if (state.favEntities.isNotEmpty) {
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: ColorsManager.lightGrey.withOpacity(0.2)),
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
                                  borderRadius: BorderRadius.circular(25)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: state.favEntities[index].image,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
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
                                state.favEntities[index].name,
                                style: getLightStyle(
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${state.favEntities[index].price} \$",
                                style: getLightStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                },
                itemCount: state.favEntities.length);
          } else {
            Center(
              child: Text("There is No Product"),
            );
          }
        } else if (state is FavErrorState) {
          return MessageDisplayWidget(message: state.errorMsg);
        }
        return SizedBox();
      },
    );
  }
}
