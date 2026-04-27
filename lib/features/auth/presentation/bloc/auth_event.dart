import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}
