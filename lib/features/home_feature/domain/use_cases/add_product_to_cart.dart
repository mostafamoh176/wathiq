import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/domain/repository/get_product_details.dart';

class AddProductToCart {
  final ProductDetailsRepository productDetailsRepository;
  AddProductToCart({required this.productDetailsRepository});
  Future<Either<Failure, Unit>> call(
      {required ProductEntities productEntities,
      required int numberOfItem}) async {
    return await productDetailsRepository.addProductToCart(
        productEntities, numberOfItem);
  }
}
