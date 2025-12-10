import 'package:equatable/equatable.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(const AuthState.unknown());

  @override
  Future<void> close() {
    if (state.isRemembered == false) {
      logout();
    }
    return super.close();
  }

  void updateAuthStatus(Map<String, dynamic> response) async {
    if (response['token'] != null && response['token'] != '') {
      emit(AuthState.authenticated(response));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  void updateUser(UserModel user) async {
    final UserModel receivedUser = user;
    final UserModel updateUser = state.user.copyWith(
      name: receivedUser.name,
      email: receivedUser.email,
      phoneNumber: receivedUser.phoneNumber,
    );
    emit(state.copyWith(user: updateUser));
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(const AuthState.unauthenticated());
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    if (json['token'] != null && json['token'] != '') {
      return AuthState.fromJson(json);
    }
    return const AuthState.unauthenticated();
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    return state.toJson();
  }
}
