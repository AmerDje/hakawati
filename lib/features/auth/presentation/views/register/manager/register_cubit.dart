import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hakawati/core/utils/constants.dart';
import 'package:hakawati/core/utils/endpoints.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;
  RegisterCubit(this.authRepository) : super(RegisterInitial());

  Future<void> register(
      {required String email,
      required String name,
      required String phone,
      required String password,
      required String locate}) async {
    emit(RegisterLoading());
    final result = await authRepository.createUserWithEmailAndPassword(
      name,
      email,
      phone,
      password,
      locate,
      Constants.kPhotoUrl,
    );
    result.fold(
        (failure) => emit(RegisterFailure(errMessage: failure.message)), (user) => emit(RegisterSuccess(user: user)));
  }

  Future<void> updateUser(UserModel user) async {
    emit(UpdateUserLoading());
    final result = await authRepository.updateUserData(user: user, endPoint: Endpoints.users);
    result.fold(
      (failure) => emit(UpdateUserFailure(errMessage: failure.message)),
      (success) => emit(const UpdateUserSuccess()),
    );
  }

  Future<void> sendEmailVerification() async {
    emit(VerificationLoading());
    var result = await authRepository.sendEmailVerification();
    result.fold((failure) => emit(VerificationFailure(errMessage: failure.message)), (success) async {
      emit(VerificationEmailSent());
      await setTimerForEmailVerification();
    });
  }

  Future<void> setTimerForEmailVerification() async {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      var result = await authRepository.reloadUserStatus();
      result.fold((failure) => emit(VerificationFailure(errMessage: failure.message)), (verified) {
        if (verified) {
          emit(VerificationSuccess());
          timer.cancel();
        }
      });
    });
  }

  Future<void> deleteUser() async {
    emit(DeleteUserLoading());
    var result = await authRepository.deleteUser();
    result.fold(
        (failure) => emit(DeleteUserFailure(errMessage: failure.message)), (success) => emit(DeleteUserSuccess()));
  }

  Future<void> temporaryLogin(String email, String password) async {
    emit(TemporaryLoginLoading());
    var result = await authRepository.temporaryLogin(email, password);
    result.fold((failure) => emit(TemporaryLoginFailure()), (_) => emit(TemporaryLoginSuccess()));
  }

  Future<void> signInWithGoogle() async {
    emit(SignInWithGoogleLoading());
    var result = await authRepository.signinWithGoogle();
    result.fold((failure) => emit(SignInWithGoogleFailure(errMessage: failure.message)),
        (googleUser) => emit(SignInWithGoogleSuccess(googleUser: googleUser)));
  }

  Future<void> signInWithFacebook() async {
    emit(SignInWithFacebookLoading());
    var result = await authRepository.signinWithFacebook();
    result.fold((failure) => emit(SignInWithFacebookFailure(errMessage: failure.message)),
        (facebookUser) => emit(SignInWithFacebookSuccess(facebookUser: facebookUser)));
  }
}
