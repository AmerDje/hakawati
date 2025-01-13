part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel user;
  final String token;
  final bool isRemembered;
  const AuthState({
    required this.status,
    required this.token,
    required this.user,
    this.isRemembered = true,
  });

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user = const UserModel(),
    this.token = '',
    this.isRemembered = true,
  });

  const AuthState.unknown() : this._();

  AuthState.authenticated(Map<String, dynamic> response)
      : this._(
          status: AuthStatus.authenticated,
          user: UserModel.fromJson(response['user']),
          token: response['token'],
          isRemembered: response['isRemembered'] ?? true,
        );

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated, token: '', isRemembered: false);

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    bool? isRemembered,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token,
      isRemembered: isRemembered ?? this.isRemembered,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      status: AuthStatus.authenticated,
      user: UserModel.fromJson(json['user']),
      token: json['token'],
      isRemembered: json['isRemembered'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
      'isRemembered': isRemembered,
    };
  }

  @override
  List<Object> get props => [status, user, token, isRemembered];
}
