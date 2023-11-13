import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomnav_state.dart';

class BottomnavCubit extends Cubit<BottomnavState> {
  BottomnavCubit() : super(BottomnavInitial());
}
