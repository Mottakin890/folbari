import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final String? phone;
  final String role;

  const ProfileEntity({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.phone,
    this.role = 'user',
  });

  bool get isAdmin => role == 'admin';

  @override
  List<Object?> get props => [id, email, name, avatarUrl, phone, role];
}
