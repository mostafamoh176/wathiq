import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/core/util/custom_fonts.dart';
import 'package:theka_task/core/util/navigation_handle.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/presentation/businees_logic/product_bloc.dart';
import 'package:theka_task/core/depency_injection/dI.dart' as di;

class ProductDetsils extends StatefulWidget {
  const ProductDetsils({super.key});

  @override
  State<ProductDetsils> createState() => _ProductDetsilsState();
}

class _ProductDetsilsState extends State<ProductDetsils> {
  @override
  Widget build(BuildContext context) {
    final ProductEntities data =
        ModalRoute.of(context)?.settings.arguments as ProductEntities;

    return BlocProvider(
      create: (context) => di.sl<ProductBloc>(),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SuccessAddToFavorite) {
            Fluttertoast.showToast(
                msg: " Added To Favorite Successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorsManager.success,
                textColor: Colors.white,
                fontSize: 16.0.sp);
          } else if (state is FavoriteAddErrorState) {
            Fluttertoast.showToast(
                msg: state.errorMsg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorsManager.error,
                textColor: Colors.white,
                fontSize: 16.0.sp);
          }
        },
        builder: (context, state) {
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeft),
                    onPressed: () => NavigationService().goBack(),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          ProductBloc.get(context)
                              .add(FavProductEvent(productEntities: data));
                        },
                        icon: Icon(FontAwesomeIcons.bookmark))
                  ],
                ),
                body: _body(product: data),
              );
            },
          );
        },
      ),
    );
  }

  Widget _body({required ProductEntities product}) {
    return Column(
      children: [
        _productImage(image: product.thumb),
        _cardDetails(productEntities: product),
      ],
    );
  }

  Widget _productImage({required String image}) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Image.asset("assets/images/errorimage.png"),
      ),
    );
  }

  Widget _cardDetails({required ProductEntities productEntities}) {
    return Expanded(
        child: Container(
      child: Column(children: [
        customTextRow(type: "Name", data: productEntities.internalName),
        customTextRow(type: "Price", data: productEntities.normalPrice),
        customTextRow(type: "Rate", data: productEntities.dealRating),
        customTextRow(type: "Saving", data: productEntities.savings),
        customTextRow(type: "Discount", data: productEntities.salePrice),
        SizedBox(
          height: 40.h,
        ),
        _addProductToCart(productEntities: productEntities)
      ]),
    ));
  }

  Padding customTextRow({required String type, required String data}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Text(
                type,
                style: getLightStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                data,
                style: getLightStyle(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addProductToCart({required ProductEntities productEntities}) {
    return BlocProvider(
      create: (context) => di.sl<ProductBloc>(),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SuccessAddProductToCart) {
            Fluttertoast.showToast(
                msg: " Added To Cart Successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorsManager.success,
                textColor: Colors.white,
                fontSize: 16.0.sp);
          }
        },
        builder: (context, state) {
          return Container(
            height: 50.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    _customButton(
                        onTap: () {
                          ProductBloc.get(context).add(AddItemInCartEvent());
                        },
                        icon: FontAwesomeIcons.add),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          ProductBloc.get(context).numberOfItem.toString(),
                          style: getRegularStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    _customButton(
                        onTap: () {
                          ProductBloc.get(context).add(MinusItemInCartEvent());
                        },
                        icon: FontAwesomeIcons.minus),
                  ],
                )),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.selection,
                  ),
                  onPressed: () {
                    ProductBloc.get(context).add(AddProductToCartEvent(
                        numberOfItems: ProductBloc.get(context).numberOfItem,
                        productEntities: productEntities));
                  },
                  child: const Text("Cart"),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _customButton(
      {required void Function()? onTap, required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        child: Icon(icon, color: ColorsManager.veryDarkGrey),
      ),
    );
  }
}
