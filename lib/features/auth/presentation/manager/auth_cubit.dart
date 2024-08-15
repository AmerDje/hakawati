import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
//import 'package:hakawati/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  // final AuthRepositoryImpl authRepositoryImpl;
  AuthCubit(//{required this.authRepositoryImpl}
      )
      : super(const AuthState.unknown()); //{
  // _authenticationStatusSubscription = authRepositoryImpl.status.listen(
  //   (status) => updateAuthStatus(status),
  // );
  //}

//  late StreamSubscription<Map<String, dynamic>> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    // _authenticationStatusSubscription.cancel();
    // authRepositoryImpl.dispose();
    if (state.isRemembered == false) {
      logout();
    }
    return super.close();
  }

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
    final UserModel receivedUser = user;
    final UserModel updateUser = state.user.copyWith(
      name: receivedUser.name,
      email: receivedUser.email,
      phoneNumber: receivedUser.phoneNumber,
    );
    emit(state.copyWith(user: updateUser));
  }

  void logout() async {
    clear();
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
