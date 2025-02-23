import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/utils/mixins/cubit_maybe_emit_mixin.dart';

import '../authentication.dart';
import '../data/repo/auth_repo.dart';

part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    AppUser? user,
    String? authToken,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
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

  void login(
    AppUser user,
    String authToken,
  ) {
    emit(
      state.copyWith(
        user: user,
        authToken: authToken,
      ),
    );
  }

  Future<void> logout() async {
    await _authRepo.logout();
    emit(
      state.copyWith(
        user: null,
        authToken: null,
      ),
    );
  }

  FormGroup formBuilder() => fb.group({
        'phone': FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(10),
          ],
        ),
        'password': FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(6),
          ],
        ),
      });

  Future<void> loginWithPhoneAndPass(String phone, String password) async {
    final userData = await _authRepo.loginWithPhoneAndPassword(phone, password);
    if (userData.isNotEmpty) {
      login(AppUser(mobileNumber: phone), userData['data']['token']);
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    final map = state.toJson();
    map.remove('phoneNumber');
    return map;
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  Future<void> loadUserDetails() async {
    final mobileNumber = state.user?.mobileNumber ?? '';

    final user = await _authRepo.getUserDetails(mobileNumber);

    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }
}
