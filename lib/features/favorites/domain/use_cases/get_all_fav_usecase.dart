import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';
import 'package:theka_task/features/cart/domain/repository/get_all_carts.dart';
import 'package:theka_task/features/favorites/domain/entities/favorite_entities.dart';
import 'package:theka_task/features/favorites/domain/repository/get_all_fav_repo.dart';

class GetAllFsvUseCase {
  final GetAllFavRepository getAllFavRepository;
  GetAllFsvUseCase({required this.getAllFavRepository});

  Future<Either<Failure, List<FavoriteEntities>>> call() =>
      getAllFavRepository.getAllFavRepository();
}
