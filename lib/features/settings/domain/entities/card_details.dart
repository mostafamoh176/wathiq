import 'package:equatable/equatable.dart';

class CardEntities extends Equatable {
  final String name;
  final int number;
  final int cvs;
  final int date;
  CardEntities(
      {required this.cvs,
      required this.date,
      required this.name,
      required this.number});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        number,
        cvs,
        date,
      ];
}
