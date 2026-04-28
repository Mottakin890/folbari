import 'package:folbari/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:folbari/features/profile/data/models/profile_model.dart';
import 'package:folbari/features/profile/domain/entities/profile_entity.dart';
import 'package:folbari/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity?> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    await remoteDataSource.updateProfile(ProfileModel.fromEntity(profile));
  }
}
