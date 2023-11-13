import 'package:equatable/equatable.dart';

class CartEntities extends Equatable {
  final String id;
  final String image;
  final String name;
  final int number;
  final String price;
  CartEntities(
      {required this.id,
      required this.image,
      required this.name,
      required this.number,
      required this.price});

  @override
  // TODO: implement props
  List<Object?> get props => [id, image, name, number, price];
}
