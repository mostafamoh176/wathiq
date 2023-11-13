import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';

abstract class GetAllCartRepository {
  Future<Either<Failure, List<CartEntities>>> getAllCartRepository();
}
