part of 'profile_cubit.dart';

class ProfileState extends BaseState {
  final BaseState actionState;
  const ProfileState({
    this.actionState = const InitState(),
  });

  ProfileState copyWith({
    BaseState? actionState,
  }) {
    return ProfileState(
      actionState: actionState ?? this.actionState,
    );
  }

  @override
  List<Object> get props => [
        actionState,
      ];
}

final class UpdateUserProfileLoading extends ProfileState {}

final class UpdateUserProfileSuccess extends ProfileState {
  final UserModel user;
  const UpdateUserProfileSuccess({required this.user});
}

final class UpdateUserProfileFailure extends ProfileState {
  final String errMessage;

  const UpdateUserProfileFailure({required this.errMessage});
}
