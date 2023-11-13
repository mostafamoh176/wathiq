import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/core/util/network.dart';
import 'package:theka_task/features/cart/data/data_source/remote_data_source.dart';
import 'package:theka_task/features/cart/data/model/cart_model.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';
import 'package:theka_task/features/cart/domain/repository/get_all_carts.dart';
import 'package:theka_task/features/favorites/data/data_source/fav_remote_data_source.dart';
import 'package:theka_task/features/favorites/domain/entities/favorite_entities.dart';
import 'package:theka_task/features/favorites/domain/repository/get_all_fav_repo.dart';

class GetAllFavRepositoryImpl implements GetAllFavRepository {
  final GetRemoteDataFavorite getRemoteDataFavorite;
  final NetworkInfo networkInfo;

  GetAllFavRepositoryImpl(
      {required this.getRemoteDataFavorite, required this.networkInfo});

  @override
  Future<Either<Failure, List<FavoriteEntities>>> getAllFavRepository() async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final List<FavoriteEntities> remoteFavData =
            await getRemoteDataFavorite.fetchAllFavorite();
        return Right(remoteFavData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(EmptyCacheFailure());
  }
}
