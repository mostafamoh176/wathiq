import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';
import 'package:theka_task/features/home_feature/domain/repository/get_product_details.dart';

class GetAllBannerUseCase {
  final ProductDetailsRepository productDetailsrepository;
  GetAllBannerUseCase({required this.productDetailsrepository});
  Future<Either<Failure, List<BannerEntities>>> call() {
    return productDetailsrepository.getAllBanner();
  }
}
