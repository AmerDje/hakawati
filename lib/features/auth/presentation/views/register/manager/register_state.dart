part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState({this.user});
  final UserModel? user;

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  @override
  final UserModel user;
  const RegisterSuccess({required this.user});
}

final class RegisterFailure extends RegisterState {
  final String errMessage;

  const RegisterFailure({required this.errMessage});
}

final class VerificationLoading extends RegisterState {}

final class VerificationSuccess extends RegisterState {}

final class VerificationEmailSent extends RegisterState {}

final class VerificationFailure extends RegisterState {
  final String errMessage;

  const VerificationFailure({required this.errMessage});
}

final class DeleteUserLoading extends RegisterState {}

final class DeleteUserSuccess extends RegisterState {}

final class DeleteUserFailure extends RegisterState {
  final String errMessage;

  const DeleteUserFailure({required this.errMessage});
}

final class UpdateUserLoading extends RegisterState {}

final class UpdateUserSuccess extends RegisterState {
  @override
  final UserModel user;
  const UpdateUserSuccess({required this.user});
}

final class UpdateUserFailure extends RegisterState {
  final String errMessage;

  const UpdateUserFailure({required this.errMessage});
}

final class SignInWithGoogleLoading extends RegisterState {}

final class SignInWithGoogleSuccess extends RegisterState {
  final UserModel googleUser;
  const SignInWithGoogleSuccess({required this.googleUser});
}

final class SignInWithGoogleFailure extends RegisterState {
  final String errMessage;

  const SignInWithGoogleFailure({required this.errMessage});
}

final class SignInWithFacebookLoading extends RegisterState {}

final class SignInWithFacebookSuccess extends RegisterState {
  final UserModel facebookUser;
  const SignInWithFacebookSuccess({required this.facebookUser});
}

final class SignInWithFacebookFailure extends RegisterState {
  final String errMessage;

  const SignInWithFacebookFailure({required this.errMessage});
}
