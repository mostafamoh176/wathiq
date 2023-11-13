import 'package:theka_task/features/home_feature/domain/entities/item_entities.dart';

class ProductModel extends ProductEntities {
  ProductModel(
      {required super.dealID,
      required super.dealRating,
      required super.gameID,
      required super.internalName,
      required super.isOnSale,
      required super.lastChange,
      required super.metacriticLink,
      required super.metacriticScore,
      required super.normalPrice,
      required super.releaseDate,
      required super.salePrice,
      required super.savings,
      required super.steamAppID,
      required super.steamRatingCount,
      required super.steamRatingPercent,
      required super.steamRatingText,
      required super.storeID,
      required super.thumb,
      required super.title});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        dealID: json["dealID"],
        dealRating: json["dealRating"],
        gameID: json["gameID"],
        internalName: json["internalName"],
        isOnSale: json["isOnSale"],
        lastChange: json["lastChange"],
        metacriticLink: json["metacriticLink"] ?? "",
        metacriticScore: json["metacriticScore"],
        normalPrice: json["normalPrice"],
        releaseDate: json["releaseDate"],
        salePrice: json["salePrice"],
        savings: json["savings"],
        steamAppID: json["steamAppID"] ?? "",
        steamRatingCount: json["steamRatingCount"],
        steamRatingPercent: json["steamRatingPercent"],
        steamRatingText: json["steamRatingText"] ?? "",
        storeID: json["storeID"],
        thumb: json["thumb"],
        title: json["title"]);
  }
}
