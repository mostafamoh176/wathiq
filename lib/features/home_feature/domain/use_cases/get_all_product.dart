import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';
import 'package:theka_task/features/home_feature/domain/repository/get_product_details.dart';

class GetAllProductUseCase {
  final ProductDetailsRepository productDetailsrepository;
  GetAllProductUseCase({required this.productDetailsrepository});
  Future<Either<Failure, List<ProductEntities>>> call() {
    return productDetailsrepository.getAllProduct();
  }
}
