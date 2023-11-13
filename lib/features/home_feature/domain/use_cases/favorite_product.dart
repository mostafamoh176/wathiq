import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/domain/repository/get_product_details.dart';

class FavProductUsecase {
  final ProductDetailsRepository productDetailsRepository;

  FavProductUsecase(this.productDetailsRepository);

  Future<Either<Failure, Unit>> call(ProductEntities productEntities) async {
    return await productDetailsRepository.addFavToProduct(productEntities);
  }
}
