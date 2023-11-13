import 'package:theka_task/features/favorites/domain/entities/favorite_entities.dart';

class FavoriteModel extends FavoriteEntities {
  FavoriteModel(
      {required super.image,
      required super.name,
      required super.price,
      required super.refrenceId});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
        image: json["image"],
        name: json["name"],
        price: json["price"],
        refrenceId: json["refrenceField"]);
  }
}
