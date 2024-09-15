import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_acf/utils/mixins/cubit_maybe_emit_mixin.dart';

import '../authentication.dart';
import '../data/repo/auth_repo.dart';

part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState(
      {AppUser? user,
      String? phoneNumber,
      int? resendToken,
      @Default(false) bool isNewUser,
      @Default(false) bool isOtpRequested}) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);
}

class AuthCubit extends HydratedCubit<AuthState> with CubitMaybeEmit {
  ///Singleton
  static AuthCubit get instance => _instance;
  static final AuthCubit _instance = AuthCubit._internal();
  late final AuthRepo _authRepo;

  AuthCubit._internal() : super(const AuthState());
  int? _caseId;
  set caseId(int? caseId) => _caseId = caseId;
  int? get workingCaseId => _caseId;

  void init(AuthRepo authRepo) {
    _authRepo = authRepo;
  }

  bool get isSignedIn => state.user != null;

  void login(AppUser user) => emit(state.copyWith(user: user));

  Future<void> logout() async {
    await _authRepo.logout();
    emit(state.copyWith(user: null, phoneNumber: null));
  }

  FormGroup formBuilder() => fb.group({
        'phone': FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(10),
          ],
        ),
      });

  Future<void> loginWithPhoneOnWeb(String phone) async {
    await _authRepo.sentOtpForWeb(phone);
    emit(state.copyWith(phoneNumber: phone));
  }

  Future<void> loginWithPhone(String phone) async {
    emit(
      state.copyWith(
        phoneNumber: phone,
        isOtpRequested: true,
      ),
    );
    await _authRepo.sendOtp(
        phone,
        (resendToken) => emit(
              state.copyWith(phoneNumber: phone, isOtpRequested: false, resendToken: resendToken),
            ),
        () => emit(
              state.copyWith(
                isOtpRequested: false,
              ),
            ));
  }

  verifyOtp(String otp) async {
    debugPrint(otp);
    await _authRepo.verifyOtp(otp);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    final map = state.toJson();
    map.remove('isOtpRequested');
    map.remove('phoneNumber');
    map.remove('resendToken');
    return map;
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  // Future<void> register(RegisterUser user) async {
  //   await _authRepo.register(user);
  // }

  Future<void> resendOtp() async {
    await _authRepo.sendOtp(
      state.phoneNumber!,
      (resendToken) => emit(
        state.copyWith(phoneNumber: state.phoneNumber, isOtpRequested: false, resendToken: resendToken),
      ),
      () => emit(
        state.copyWith(
          isOtpRequested: false,
        ),
      ),
    );
  }

  Future<void> loadUserDetails() async {
    final user = await _authRepo.getUserDetails();

    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }
}
