import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
    final result = await authRepository.register(email, password, locate);
    result.fold((failure) => emit(RegisterFailure(errMessage: failure.message)), (firebaseUser) async {
      final userModel = UserModel(
        uid: firebaseUser.uid,
        password: password,
        email: email,
        name: name,
        emailVerified: firebaseUser.emailVerified,
        phoneNumber: phone,
        locate: locate,
        photoUrl: 'https://img.freepik.com/premium-vector/bearded-smiling-man-with-arms-crossed_165429-132.jpg?w=740',
      );
      final result = await authRepository.createUser(userModel);
      result.fold((failure) => emit(RegisterFailure(errMessage: failure.message)),
          (user) => emit(RegisterSuccess(user: userModel)));
    });
  }

  Future<void> updateUser(UserModel user) async {
    emit(UpdateUserLoading());
    final result = await authRepository.updatePersonalData(user);
    result.fold(
      (failure) => emit(UpdateUserFailure(errMessage: failure.message)),
      (user) => emit(UpdateUserSuccess(user: user)),
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

  Future<void> signInWithGoogle() async {
    emit(SignInWithGoogleLoading());
    var result = await authRepository.signInWithGoogle();
    result.fold((failure) => emit(SignInWithGoogleFailure(errMessage: failure.message)),
        (googleUser) => emit(SignInWithGoogleSuccess(googleUser: googleUser)));
  }

  Future<void> signInWithFacebook() async {
    emit(SignInWithFacebookLoading());
    var result = await authRepository.signInWithFacebook();
    result.fold((failure) => emit(SignInWithFacebookFailure(errMessage: failure.message)),
        (facebookUser) => emit(SignInWithFacebookSuccess(facebookUser: facebookUser)));
  }
}
