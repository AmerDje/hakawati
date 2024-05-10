part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
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
