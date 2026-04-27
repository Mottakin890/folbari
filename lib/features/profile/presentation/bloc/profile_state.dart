import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
