import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, List<ProductEntities>>> getAllProduct();
  Future<Either<Failure, Unit>> addFavToProduct(
      ProductEntities productEntities);
  Future<Either<Failure, List<BannerEntities>>> getAllBanner();
  Future<Either<Failure, Unit>> addProductToCart(
      ProductEntities productEntities, int numberOfItem);
}
