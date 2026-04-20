import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class GoogleSignInRequested extends AuthEvent {}
final class SignOutRequested extends AuthEvent {}
final class AuthCheckRequested extends AuthEvent {}
