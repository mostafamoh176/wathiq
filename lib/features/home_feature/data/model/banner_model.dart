import 'dart:convert';

import 'package:theka_task/features/home_feature/domain/entities/banner_entities.dart';

class BannerModel extends BannerEntities {
  BannerModel(
      {required super.image,
      required super.isShow,
      required super.lengthToShow});
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
        image: json["image"] ?? "",
        isShow: json["isShow"],
        lengthToShow: json["lengthToShow"]);
  }
}
