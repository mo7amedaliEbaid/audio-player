part of 'cubit.dart';

@immutable
class AuthState extends Equatable {
  final User? data;
  final String? url;
  final String? message;

  const AuthState({
    this.data,
    this.url,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        url,
        message,
      ];
}

@immutable
class AuthDefault extends AuthState {}

// login
@immutable
class AuthLoginLoading extends AuthState {
  const AuthLoginLoading() : super();
}

@immutable
class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess({User? data}) : super(data: data);
}

@immutable
class AuthLoginFailed extends AuthState {
  const AuthLoginFailed({String? message}) : super(message: message);
}

// signup
@immutable
class AuthSignUpLoading extends AuthState {
  const AuthSignUpLoading() : super();
}

@immutable
class AuthSignUpSuccess extends AuthState {
  const AuthSignUpSuccess({User? data}) : super(data: data);
}

@immutable
class AuthSignUpFailed extends AuthState {
  const AuthSignUpFailed({String? message}) : super(message: message);
}

// logout
@immutable
class AuthLogoutLoading extends AuthState {
  const AuthLogoutLoading() : super();
}

@immutable
class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess() : super();
}

@immutable
class AuthLogoutFailed extends AuthState {
  const AuthLogoutFailed({String? message}) : super(message: message);
}

// forgot password
@immutable
class AuthForgotPasswordLoading extends AuthState {
  const AuthForgotPasswordLoading() : super();
}

@immutable
class AuthForgotPasswordSuccess extends AuthState {
  const AuthForgotPasswordSuccess() : super();
}

@immutable
class AuthForgotPasswordFailed extends AuthState {
  const AuthForgotPasswordFailed({String? message}) : super(message: message);
}

// gmail social login
@immutable
class GmailLoginLoading extends AuthState {
  const GmailLoginLoading() : super();
}

@immutable
class GmailLoginSuccess extends AuthState {
  const GmailLoginSuccess({User? data}) : super(data: data);
}

@immutable
class GmailLoginFailed extends AuthState {
  const GmailLoginFailed({String? message}) : super(message: message);
}

// fb social login
@immutable
class FBLoginLoading extends AuthState {
  const FBLoginLoading() : super();
}

@immutable
class FBLoginSuccess extends AuthState {
  const FBLoginSuccess({User? data}) : super(data: data);
}

@immutable
class FBLoginFailed extends AuthState {
  const FBLoginFailed({String? message}) : super(message: message);
}
