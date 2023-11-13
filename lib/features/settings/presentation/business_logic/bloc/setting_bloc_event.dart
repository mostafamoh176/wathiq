part of 'setting_bloc_bloc.dart';

sealed class SettingBlocEvent extends Equatable {
  const SettingBlocEvent();

  @override
  List<Object> get props => [];
}

class CahedCreditCardsEvent extends SettingBlocEvent {
  final CardEntities cardEntities;
  CahedCreditCardsEvent({required this.cardEntities});
  @override
  List<Object> get props => [cardEntities];
}

class DeletedCardsEvent extends SettingBlocEvent {}
