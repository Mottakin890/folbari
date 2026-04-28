import 'package:folbari/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity?> getProfile();
  Future<void> updateProfile(ProfileEntity profile);
}
