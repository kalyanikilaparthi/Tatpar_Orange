import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/mental_health_screening_model.dart';
import 'package:tatpar_orange/features/mentalhealthscreening/model/who_srq_model.dart';
part 'who_srq_cubit.freezed.dart';

part 'who_srq_cubit.g.dart';

@freezed
class WHOSrqState with _$WHOSrqState {
  const factory WHOSrqState({
    required bool isLoading,
    WHOSrqModel? whoSrqModel,
    MentalHealthScreeningModel? mentalHealthScreeningModel,
  }) = _WHOSrqState;
  factory WHOSrqState.fromJson(Map<String, dynamic> json) =>
      _$WHOSrqStateFromJson(json);
}

class WHOSrqStateCubit extends Cubit<WHOSrqState> {
  WHOSrqStateCubit() : super(const WHOSrqState(isLoading: true));
  void updateWhoSrqModel(WHOSrqModel model) {
    emit(state.copyWith(isLoading: false, whoSrqModel: model));
  }

  Map<String, dynamic> calculateYesCounter(FormGroup formGroup) {
    int numberOfYes = 0;
    String screeningStatus;
    formGroup.controls.forEach((key, control) {
      if (control.value?.toString() == 'Yes') {
        numberOfYes++;
      }
    });
    if (numberOfYes > 14 ||
        (formGroup.control('ending_your_life').value == 'Yes' &&
            numberOfYes < 15)) {
      screeningStatus = 'Positive';
    } else {
      screeningStatus = 'Negative';
    }
    return {
      'yesCounter': numberOfYes,
      'screeningStatus': screeningStatus,
    };
  }

  void updateMentalHealthScreeningModel(MentalHealthScreeningModel model) {
    emit(state.copyWith(isLoading: false, mentalHealthScreeningModel: model));
  }
}
