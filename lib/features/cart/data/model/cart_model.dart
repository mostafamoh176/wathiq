import 'package:theka_task/features/cart/domain/entities/cart_entities.dart';

class CartModel extends CartEntities {
  CartModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.number,
      required super.price});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      number: json["number"],
      price: json["price"],
    );
  }
}
