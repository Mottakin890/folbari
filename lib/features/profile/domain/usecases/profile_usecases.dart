import 'package:folbari/features/profile/domain/entities/profile_entity.dart';
import 'package:folbari/features/profile/domain/repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<ProfileEntity?> call() async {
    return await repository.getProfile();
  }
}

class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  Future<void> call(ProfileEntity profile) async {
    await repository.updateProfile(profile);
  }
}
