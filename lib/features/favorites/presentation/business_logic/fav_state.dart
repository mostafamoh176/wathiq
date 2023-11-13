part of 'fav_bloc.dart';

sealed class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

final class FavInitial extends FavState {}

final class FavLoadingState extends FavState {}

final class FavLoadedState extends FavState {
  final List<FavoriteEntities> favEntities;

  const FavLoadedState({required this.favEntities});

  @override
  List<Object> get props => [favEntities];
}

final class FavErrorState extends FavState {
  final String errorMsg;
  const FavErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
