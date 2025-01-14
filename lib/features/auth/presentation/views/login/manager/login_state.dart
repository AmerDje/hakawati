part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  final UserModel? user;
  final String? errMessage;
  const LoginState({this.user, this.errMessage});

  @override
  List<Object?> get props => [user, errMessage];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  const LoginSuccess({required super.user});
}

final class LoginFailure extends LoginState {
  const LoginFailure({required super.errMessage});
}

final class LogoutLoading extends LoginState {}

final class LogoutSuccess extends LoginState {}

final class LogoutFailure extends LoginState {
  const LogoutFailure({required super.errMessage});
}

final class SignInWithGoogleLoading extends LoginState {}

final class SignInWithGoogleSuccess extends LoginState {
  const SignInWithGoogleSuccess({required super.user});
}

final class SignInWithGoogleFailure extends LoginState {
  const SignInWithGoogleFailure({required super.errMessage});
}

final class SignInWithFacebookLoading extends LoginState {}

final class SignInWithFacebookSuccess extends LoginState {
  const SignInWithFacebookSuccess({required super.user});
}

final class SignInWithFacebookFailure extends LoginState {
  const SignInWithFacebookFailure({required super.errMessage});
}
