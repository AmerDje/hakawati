part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  final UserModel? user;
  final String? errMessage;
  const RegisterState({this.user, this.errMessage});

  @override
  List<Object?> get props => [user, errMessage];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({required super.user});
}

final class RegisterFailure extends RegisterState {
  const RegisterFailure({required super.errMessage});
}

final class VerificationLoading extends RegisterState {}

final class VerificationSuccess extends RegisterState {}

final class VerificationEmailSent extends RegisterState {}

final class VerificationFailure extends RegisterState {
  const VerificationFailure({required super.errMessage});
}

final class DeleteUserLoading extends RegisterState {}

final class DeleteUserSuccess extends RegisterState {}

final class DeleteUserFailure extends RegisterState {
  const DeleteUserFailure({required super.errMessage});
}

final class UpdateUserLoading extends RegisterState {}

final class UpdateUserSuccess extends RegisterState {
  const UpdateUserSuccess();
}

final class UpdateUserFailure extends RegisterState {
  const UpdateUserFailure({required super.errMessage});
}

final class SignInWithGoogleLoading extends RegisterState {}

final class SignInWithGoogleSuccess extends RegisterState {
  final UserModel googleUser;
  const SignInWithGoogleSuccess({required this.googleUser});
}

final class SignInWithGoogleFailure extends RegisterState {
  const SignInWithGoogleFailure({required super.errMessage});
}

final class SignInWithFacebookLoading extends RegisterState {}

final class SignInWithFacebookSuccess extends RegisterState {
  final UserModel facebookUser;
  const SignInWithFacebookSuccess({required this.facebookUser});
}

final class SignInWithFacebookFailure extends RegisterState {
  const SignInWithFacebookFailure({required super.errMessage});
}

final class TemporaryLoginLoading extends RegisterState {}

final class TemporaryLoginSuccess extends RegisterState {}

final class TemporaryLoginFailure extends RegisterState {}
