part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetEventProduct extends ProductEvent {}

class AddItemInCartEvent extends ProductEvent {}

class MinusItemInCartEvent extends ProductEvent {}

class FavProductEvent extends ProductEvent {
  final ProductEntities productEntities;
  const FavProductEvent({required this.productEntities});
  @override
  List<Object> get props => [productEntities];
}

class GetAllBannerEvent extends ProductEvent {}

class AddProductToCartEvent extends ProductEvent {
  final ProductEntities productEntities;
  final int numberOfItems;
  const AddProductToCartEvent(
      {required this.numberOfItems, required this.productEntities});
}
