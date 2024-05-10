part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel user;
  final String token;
  const AuthState({
    required this.status,
    required this.token,
    required this.user,
  });

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user = UserModel.empty,
    this.token = '',
  });

  const AuthState.unknown() : this._();

  AuthState.authenticated(Map<String, dynamic> response)
      : this._(
          status: AuthStatus.authenticated,
          user: UserModel.fromJson(response['user']),
          token: response['token'],
        );

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated, token: '');

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      status: AuthStatus.authenticated,
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
    };
  }

  @override
  List<Object> get props => [status, user, token];
}
