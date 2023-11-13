import 'package:theka_task/features/settings/domain/entities/card_details.dart';

class CardModel extends CardEntities {
  CardModel(
      {required super.cvs,
      required super.date,
      required super.name,
      required super.number});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        cvs: json["cvs"],
        date: json["date"],
        name: json["name"],
        number: json["number"]);
  }

  Map<String, dynamic> toJson() {
    return {'cvs': cvs, 'date': date, 'name': name, 'number': number};
  }
}
