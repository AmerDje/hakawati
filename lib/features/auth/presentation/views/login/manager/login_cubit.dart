import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await authRepository.login(email, password);
    result.fold(
      (failure) => emit(LoginFailure(errMessage: failure.message)),
      (loggedUser) {
        fetchUserData(loggedUser.uid!);
      },
    );
  }

  Future<void> fetchUserData(String uid) async {
    emit(LoginLoading());
    final result = await authRepository.fetchPersonalData(uid);
    result.fold(
      (failure) => emit(LoginFailure(errMessage: failure.message)),
      (loggedUser) => emit(LoginSuccess(user: loggedUser)),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await authRepository.logout();
    result.fold(
      (failure) => emit(LogoutFailure(errMessage: failure.message)),
      (loggedUser) => emit(LogoutSuccess()),
    );
  }
}
