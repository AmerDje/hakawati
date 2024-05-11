part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
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
