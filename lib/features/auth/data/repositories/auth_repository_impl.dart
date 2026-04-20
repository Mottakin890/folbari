import 'package:folbari/core/utils/logger.dart';
import 'package:folbari/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:folbari/features/auth/domain/entities/user_entity.dart';
import 'package:folbari/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity?> signInWithGoogle() async {
    logger.d('AuthRepository: signInWithGoogle called');
    return await remoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    logger.d('AuthRepository: signOut called');
    await remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    logger.d('AuthRepository: getCurrentUser called');
    return remoteDataSource.getCurrentUser();
  }
}
