import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/core/util/paths.dart';
import 'package:theka_task/core/widgets/custom_loading_widget.dart';
import 'package:theka_task/core/widgets/message_display_widget.dart';
import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/presentation/businees_logic/product_bloc.dart';
import 'package:theka_task/features/home_feature/presentation/widgets/custom_app_bar.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() => MyAppBar(
        actionButtonHeight: 60.h,
      );

  Widget _body() {
    return Column(
      children: [_sliderShow(), _productGrid()],
    );
  }

  Widget _sliderShow() {
    return BlocProvider(
      create: (context) => di.sl<ProductBloc>()..add(GetAllBannerEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is BannerLoadingState) {
          return LoadingWidget();
        } else if (state is BannerLoadedState) {
          return CarouselSlider.builder(
            itemCount: state.bannerList.length,
            options: CarouselOptions(
              height: 150.h,
              autoPlay: true,
            ),
            itemBuilder: (context, index, index2) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.black, width: 2)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: state.bannerList[index].image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is BannerErrorState) {
          return MessageDisplayWidget(message: state.errorMsg);
        }
        return SizedBox();
      }),
    );
  }

  Widget _productGrid() {
    return BlocProvider(
      create: (context) => di.sl<ProductBloc>()..add(GetEventProduct()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return LoadingWidget();
          } else if (state is ProductLoadedState) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 15, // Spacing between columns
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 3 / 2, // Spacing between rows
                  ),
                  itemCount: state
                      .productEntities.length, // Number of items in the grid
                  itemBuilder: (context, index) {
                    // Builder function for creating grid items
                    return InkWell(
                      onTap: () => NavigationService().navigateTo(
                          Paths.CARD_DETAILS, state.productEntities[index]),
                      child: _cardComponent(
                          productEntities: state.productEntities[index]),
                    );
                  },
                ),
              ),
            );
          } else if (state is ProductErrorState) {
            return ErrorWidget(state.errorMsg);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _cardComponent({required ProductEntities productEntities}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Material(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager.lightGrey.withOpacity(0.2),
          ),
          child: Column(children: [
            Expanded(
              flex: 3,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: productEntities.thumb,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Expanded(
                child: Text(
              productEntities.internalName,
              style: getEtraLightStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    productEntities.dealRating,
                    style: getEtraLightStyle(
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${productEntities.normalPrice} \$",
                    style: getEtraLightStyle(
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
