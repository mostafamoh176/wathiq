import 'package:equatable/equatable.dart';

class ProductEntities extends Equatable {
  final String internalName;
  final String title;
  final String metacriticLink;
  final String dealID;
  final String storeID;
  final String gameID;
  final String salePrice;
  final String normalPrice;
  final String isOnSale;
  final String savings;
  final String metacriticScore;
  final String steamRatingText;
  final String steamRatingPercent;
  final String steamRatingCount;
  final String steamAppID;
  final int releaseDate;
  final int lastChange;
  final String dealRating;
  final String thumb;
  ProductEntities({
    required this.dealID,
    required this.dealRating,
    required this.gameID,
    required this.internalName,
    required this.isOnSale,
    required this.lastChange,
    required this.metacriticLink,
    required this.metacriticScore,
    required this.normalPrice,
    required this.releaseDate,
    required this.salePrice,
    required this.savings,
    required this.steamAppID,
    required this.steamRatingCount,
    required this.steamRatingPercent,
    required this.steamRatingText,
    required this.storeID,
    required this.thumb,
    required this.title,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        dealID,
        dealRating,
        gameID,
        internalName,
        isOnSale,
        lastChange,
        metacriticLink,
        metacriticScore,
        normalPrice,
        releaseDate,
        salePrice,
        savings,
        steamAppID,
        steamRatingCount,
        steamRatingPercent,
        steamRatingText,
        storeID,
        thumb,
        title,
      ];
}
