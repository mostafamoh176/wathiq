// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/core/util/strings.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';
import 'package:theka_task/features/cart/domain/use_cases/get_all_cart_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  static CartBloc get(context) => BlocProvider.of(context);
  final GetAllCartUseCase getAllCartUseCase;
  CartBloc({required this.getAllCartUseCase}) : super(CartInitial()) {
    // get All Remote Cart
    on<GetEventCart>((event, emit) async {
      emit(CartLoadingState());
      final cartData = await getAllCartUseCase();
      cartData.fold((failure) {
        emit(CartErrorState(errorMsg: _mapFailureToMessage(failure)));
      }, (success) {
        emit(CartLoadedState(cartEntities: success));
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
