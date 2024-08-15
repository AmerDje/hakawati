part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final UserModel? user;
  const LoginState({this.user});

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  @override
  final UserModel user;

  const LoginSuccess({required this.user});
}

final class LoginFailure extends LoginState {
  final String errMessage;

  const LoginFailure({required this.errMessage});
}

final class LogoutLoading extends LoginState {}

final class LogoutSuccess extends LoginState {}

final class LogoutFailure extends LoginState {
  final String errMessage;

  const LogoutFailure({required this.errMessage});
}

final class SignInWithGoogleLoading extends LoginState {}

final class SignInWithGoogleSuccess extends LoginState {
  @override
  final UserModel user;
  const SignInWithGoogleSuccess({required this.user});
}

final class SignInWithGoogleFailure extends LoginState {
  final String errMessage;

  const SignInWithGoogleFailure({required this.errMessage});
}

final class SignInWithFacebookLoading extends LoginState {}

final class SignInWithFacebookSuccess extends LoginState {
  @override
  final UserModel user;
  const SignInWithFacebookSuccess({required this.user});
}

final class SignInWithFacebookFailure extends LoginState {
  final String errMessage;

  const SignInWithFacebookFailure({required this.errMessage});
}
