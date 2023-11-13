part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartLoadedState extends CartState {
  final List<CartEntities> cartEntities;

  const CartLoadedState({required this.cartEntities});

  @override
  List<Object> get props => [cartEntities];
}

final class CartErrorState extends CartState {
  final String errorMsg;
  const CartErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
