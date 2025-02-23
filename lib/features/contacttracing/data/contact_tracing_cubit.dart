import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tatpar_orange/features/case/data/repos/case_repo.dart';
import 'package:tatpar_orange/features/contacttracing/models/contact_tracing_model.dart';
part 'contact_tracing_cubit.freezed.dart';
part 'contact_tracing_cubit.g.dart';

@freezed
class ContactTracingState with _$ContactTracingState {
  const factory ContactTracingState({
    bool? isLoading,
    @Default([]) List<ContactTracingModel> contactTracingList,
    required ContactTracingModel contactTracingModel,
  }) = _ContactTracingState;

  factory ContactTracingState.fromJson(Map<String, dynamic> json) =>
      _$ContactTracingStateFromJson(json);
}

class ContactTracingCubit extends Cubit<ContactTracingState> {
  final CaseRepo repo;

  ContactTracingCubit(
      {required this.repo, required ContactTracingModel contactTracingModel})
      : super(ContactTracingState(contactTracingModel: contactTracingModel));

  void updateSingleCase(ContactTracingModel updatedContact) {
    final contactList = state.contactTracingList;
    final index =
        contactList.indexWhere((element) => element.id == updatedContact.id);

    if (index == -1) return;
    List<ContactTracingModel> contactCopy = List.from(contactList);
    contactCopy[index] = updatedContact;
    emit(
      state.copyWith(contactTracingList: contactCopy),
    );
  }

  void updateContact(ContactTracingModel? updatedContact) {
    emit(state.copyWith(
        contactTracingModel: updatedContact ?? const ContactTracingModel()));
  }
}
