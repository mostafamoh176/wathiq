part of 'setting_bloc_bloc.dart';

sealed class SettingBlocState extends Equatable {
  const SettingBlocState();

  @override
  List<Object> get props => [];
}

final class SettingBlocInitial extends SettingBlocState {}

final class CashingLoadingState extends SettingBlocState {}

final class CashingSuccessfullyState extends SettingBlocState {}

final class DeleteSuccessfullyState extends SettingBlocState {}
