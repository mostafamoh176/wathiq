part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  final List<ProductEntities> productEntities;

  ProductLoadedState({required this.productEntities});

  @override
  List<Object> get props => [productEntities];
}

final class ProductErrorState extends ProductState {
  final String errorMsg;
  ProductErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

final class AddOrMinusProduct extends ProductState {
  final int val;
  AddOrMinusProduct({required this.val});
  @override
  List<Object> get props => [val];
}

final class FavoriteAddErrorState extends ProductState {
  final String errorMsg;
  const FavoriteAddErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

final class SuccessAddToFavorite extends ProductState {}

final class BannerLoadingState extends ProductState {}

final class BannerLoadedState extends ProductState {
  final List<BannerEntities> bannerList;
  const BannerLoadedState({required this.bannerList});
}

final class BannerErrorState extends ProductState {
  final String errorMsg;
  const BannerErrorState({required this.errorMsg});
}

final class ProductAddErrorState extends ProductState {
  final String errorMsg;
  const ProductAddErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

final class SuccessAddProductToCart extends ProductState {}
