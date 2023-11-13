import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/core/util/network.dart';
import 'package:theka_task/features/cart/data/data_source/remote_data_source.dart';
import 'package:theka_task/features/cart/data/model/cart_model.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';
import 'package:theka_task/features/cart/domain/repository/get_all_carts.dart';

class GetAllCartRepositoryImpl implements GetAllCartRepository {
  final GetRemoteData getRemoteData;
  final NetworkInfo networkInfo;

  GetAllCartRepositoryImpl(
      {required this.getRemoteData, required this.networkInfo});

  @override
  Future<Either<Failure, List<CartEntities>>> getAllCartRepository() async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final List<CartModel> remoteCartData =
            await getRemoteData.fetchAllProductCart();
        return Right(remoteCartData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(EmptyCacheFailure());
  }
}
