import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/features/app/presentation/widgets/app_check_list.dart';

class ReactiveCheckList extends ReactiveFormField<List<bool>, List<bool>> {
  /// Constructs an instance of [ReactiveCheckList].
  ///
  /// The argument [formControlName] must not be null.
  ReactiveCheckList({
    super.key,
    required String label,
    required String formControlName,
    required List<String> items,
  }) : super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<List<bool>, List<bool>> field) {
            // RatingBar inner widget
            return AppCheckList(
              items: items,
              selectedList: field.value ?? [],
              label: label,
              onSelected: (values){
                field.didChange(values);
              }
            );
          },
        );

  @override
  ReactiveFormFieldState<List<bool>, List<bool>> createState() =>
      ReactiveFormFieldState<List<bool>, List<bool>>();
}
