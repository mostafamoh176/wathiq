import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/favorites/domain/entities/favorite_entities.dart';

abstract class GetAllFavRepository {
  Future<Either<Failure, List<FavoriteEntities>>> getAllFavRepository();
}
