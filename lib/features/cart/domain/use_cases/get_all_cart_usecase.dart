import 'package:dartz/dartz.dart';
import 'package:theka_task/core/error/failure.dart';
import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';
import 'package:theka_task/features/cart/domain/repository/get_all_carts.dart';

class GetAllCartUseCase {
  final GetAllCartRepository getAllCartRepository;
  GetAllCartUseCase({required this.getAllCartRepository});

  Future<Either<Failure, List<CartEntities>>> call() =>
      getAllCartRepository.getAllCartRepository();
}
