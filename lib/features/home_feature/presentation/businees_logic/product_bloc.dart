// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/core/util/strings.dart';
import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/add_product_to_cart.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/favorite_product.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/get_all_banner.dart';
import 'package:theka_task/features/home_feature/domain/use_cases/get_all_product.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  static ProductBloc get(context) => BlocProvider.of(context);
  final GetAllProductUseCase getAllProductUseCase;
  final FavProductUsecase favProductUsecase;
  final GetAllBannerUseCase getAllBannerUseCase;
  final AddProductToCart addProductToCart;
  ProductBloc(
      {required this.getAllProductUseCase,
      required this.addProductToCart,
      required this.favProductUsecase,
      required this.getAllBannerUseCase})
      : super(ProductInitial()) {
    //Get product event

    on<ProductEvent>((event, emit) async {
      if (event is GetEventProduct) {
        emit(ProductLoadingState());
        final questationsData = await getAllProductUseCase();
        questationsData.fold((failure) {
          emit(ProductErrorState(errorMsg: _mapFailureToMessage(failure)));
        }, (success) {
          emit(ProductLoadedState(productEntities: success));
        });
      }
    });

    //Add or minus Event in cart

    on<AddItemInCartEvent>((event, emit) async {
      emit(AddOrMinusProduct(val: numberOfItem++));
    });

    on<MinusItemInCartEvent>((event, emit) async {
      emit(AddOrMinusProduct(val: (numberOfItem != 0) ? numberOfItem-- : 0));
    });

    on<FavProductEvent>((event, emit) async {
      final press = await favProductUsecase(event.productEntities);
      press.fold((failure) {
        emit(FavoriteAddErrorState(errorMsg: failure.toString()));
      }, (success) {
        emit(SuccessAddToFavorite());
      });
    });

    // get All Remote Banner
    on<GetAllBannerEvent>((event, emit) async {
      emit(BannerLoadingState());
      final bannerData = await getAllBannerUseCase();
      bannerData.fold((failure) {
        emit(BannerErrorState(errorMsg: _mapFailureToMessage(failure)));
      }, (success) {
        emit(BannerLoadedState(bannerList: success));
      });
    });

    // add product to cart
    on<AddProductToCartEvent>((event, emit) async {
      final press = await addProductToCart(
        productEntities: event.productEntities,
        numberOfItem: event.numberOfItems,
      );
      press.fold((failure) {
        emit(ProductAddErrorState(errorMsg: failure.toString()));
      }, (success) {
        emit(SuccessAddProductToCart());
      });
    });
  }

  int numberOfItem = 0;

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
