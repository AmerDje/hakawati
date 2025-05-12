import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'personalize_state.dart';

class PersonalizeCubit extends Cubit<PersonalizeState> {
  PersonalizeCubit() : super(const PersonalizeState());

  void changePage(int value) {
    emit(state.copyWith(pageIndex: value));
  }

  void updateFormResult(int pageIndex, dynamic result) {
    final newResults = List.from(state.formResults);
    newResults[pageIndex] = result;
    emit(state.copyWith(formResults: newResults));
  }
}
