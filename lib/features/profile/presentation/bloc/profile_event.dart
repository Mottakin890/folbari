import 'package:equatable/equatable.dart';

import 'package:folbari/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileEntity profile;
  const UpdateProfileEvent(this.profile);
  @override
  List<Object?> get props => [profile];
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
}
