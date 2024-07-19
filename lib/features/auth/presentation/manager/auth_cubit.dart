import 'package:equatable/equatable.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(const AuthState.unknown());

  void updateAuthStatus(dynamic response) async {
    if (response['token'] != null && response['token'] != '') {
      emit(AuthState.authenticated(response));
    } else if (response['token'] == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(const AuthState.unknown());
    }
  }

  void updateUser(UserModel user) async {
    emit(state.copyWith(user: user));
  }

  void logout() async {
    emit(const AuthState.unauthenticated());
    clear();
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

  @override
  Future<void> close() async {
    if (state.isRemembered == false) {
      logout();
    }
    super.close();
  }
}
