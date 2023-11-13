// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/core/util/strings.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';
import 'package:theka_task/features/cart/domain/use_cases/get_all_cart_usecase.dart';
import 'package:theka_task/features/favorites/domain/entities/favorite_entities.dart';
import 'package:theka_task/features/favorites/domain/use_cases/get_all_fav_usecase.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  static FavBloc get(context) => BlocProvider.of(context);
  final GetAllFsvUseCase getAllFavUseCase;
  FavBloc({required this.getAllFavUseCase}) : super(FavInitial()) {
    // get All Remote Fav
    on<GetEventFav>((event, emit) async {
      emit(FavLoadingState());
      final favData = await getAllFavUseCase();
      favData.fold((failure) {
        emit(FavErrorState(errorMsg: _mapFailureToMessage(failure)));
      }, (success) {
        emit(FavLoadedState(favEntities: success));
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
