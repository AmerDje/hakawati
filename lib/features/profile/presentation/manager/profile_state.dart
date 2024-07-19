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
