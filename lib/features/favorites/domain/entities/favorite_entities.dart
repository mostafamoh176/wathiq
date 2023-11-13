import 'package:equatable/equatable.dart';

class FavoriteEntities extends Equatable {
  final String image;
  final String name;
  final String price;
  final String refrenceId;
  FavoriteEntities(
      {required this.image,
      required this.name,
      required this.price,
      required this.refrenceId});
  @override
  // TODO: implement props
  List<Object?> get props => [image, name, price, refrenceId];
}
