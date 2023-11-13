import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/exception.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/core/util/network.dart';
import 'package:theka_task/features/home_feature/data/data_source/remote_dat_source.dart';
import 'package:theka_task/features/home_feature/data/model/item_model.dart';
import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/domain/repository/get_product_details.dart';

class GetAllProductRepositoryImpl implements ProductDetailsRepository {
  final ProductRemoteDataSource productRemoteData;
  final NetworkInfo networkInfo;
  GetAllProductRepositoryImpl(
      {required this.productRemoteData, required this.networkInfo});
  @override
  Future<Either<Failure, List<ProductEntities>>> getAllProduct() async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final remoteProduct = await productRemoteData.getAllProductModel();

        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(EmptyCacheFailure());
  }

  @override
  Future<Either<Failure, Unit>> addFavToProduct(
      ProductEntities productEntities) async {
    final ProductModel productModel = ProductModel(
        dealID: productEntities.dealID,
        dealRating: productEntities.dealRating,
        gameID: productEntities.gameID,
        internalName: productEntities.internalName,
        isOnSale: productEntities.isOnSale,
        lastChange: productEntities.lastChange,
        metacriticLink: productEntities.metacriticLink,
        metacriticScore: productEntities.metacriticScore,
        normalPrice: productEntities.normalPrice,
        releaseDate: productEntities.releaseDate,
        salePrice: productEntities.salePrice,
        savings: productEntities.savings,
        steamAppID: productEntities.steamAppID,
        steamRatingCount: productEntities.steamRatingCount,
        steamRatingPercent: productEntities.steamRatingPercent,
        steamRatingText: productEntities.steamRatingText,
        storeID: productEntities.storeID,
        thumb: productEntities.thumb,
        title: productEntities.title);
    return await _getMessage(() {
      productRemoteData.favProductsDpcument(productModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(addOrDelete) async {
    if (await networkInfo.isDeviceConnected) {
      try {
        await addOrDelete();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<BannerEntities>>> getAllBanner() async {
    if (await networkInfo.isDeviceConnected) {
      try {
        final remoteBanner = await productRemoteData.getAllBannerModel();

        return Right(remoteBanner);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(EmptyCacheFailure());
  }

  @override
  Future<Either<Failure, Unit>> addProductToCart(
      ProductEntities productEntities, int numberOfItem) async {
    final ProductModel productModel = ProductModel(
        dealID: productEntities.dealID,
        dealRating: productEntities.dealRating,
        gameID: productEntities.gameID,
        internalName: productEntities.internalName,
        isOnSale: productEntities.isOnSale,
        lastChange: productEntities.lastChange,
        metacriticLink: productEntities.metacriticLink,
        metacriticScore: productEntities.metacriticScore,
        normalPrice: productEntities.normalPrice,
        releaseDate: productEntities.releaseDate,
        salePrice: productEntities.salePrice,
        savings: productEntities.savings,
        steamAppID: productEntities.steamAppID,
        steamRatingCount: productEntities.steamRatingCount,
        steamRatingPercent: productEntities.steamRatingPercent,
        steamRatingText: productEntities.steamRatingText,
        storeID: productEntities.storeID,
        thumb: productEntities.thumb,
        title: productEntities.title);
    return await _getMessage(() {
      productRemoteData.addProductToCart(
          productModel: productModel, numberOfItem: numberOfItem);
    });
  }
}
