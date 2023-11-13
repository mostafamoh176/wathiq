import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theka_task/features/settings/domain/entities/card_details.dart';
import 'package:theka_task/features/settings/domain/use_cases/cash_Credit_details.dart';
import 'package:theka_task/features/settings/domain/use_cases/check_clear_card.dart';

part 'setting_bloc_event.dart';
part 'setting_bloc_state.dart';

class SettingBlocBloc extends Bloc<SettingBlocEvent, SettingBlocState> {
  static SettingBlocBloc get(context) => BlocProvider.of(context);

  final CashCreditDataUseCase cashCreditDataUseCase;
  final CashCreditUseCase cashCreditUseCase;

  SettingBlocBloc(
      {required this.cashCreditUseCase, required this.cashCreditDataUseCase})
      : super(SettingBlocInitial()) {
    on<CahedCreditCardsEvent>((event, emit) async {
      await cashCreditDataUseCase(cardEntities: event.cardEntities);
      emit(CashingSuccessfullyState());
    });
    on<DeletedCardsEvent>((event, emit) async {
      await cashCreditUseCase();
      emit(DeleteSuccessfullyState());
    });
  }
}
