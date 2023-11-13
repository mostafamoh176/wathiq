import 'package:equatable/equatable.dart';

class BannerEntities extends Equatable {
  final String image;
  final bool isShow;
  final int lengthToShow;
  BannerEntities(
      {required this.image, required this.isShow, required this.lengthToShow});

  @override
  // TODO: implement props
  List<Object?> get props => [image, isShow, lengthToShow];
}
