import 'package:folbari/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:folbari/features/admin/domain/repositories/admin_repository.dart';
import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:folbari/features/profile/data/models/profile_model.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProfileModel>> getAllUsers() => remoteDataSource.getAllUsers();

  @override
  Future<void> deleteUser(String userId) => remoteDataSource.deleteUser(userId);

  @override
  Future<void> updateUserRole(String userId, String role) => remoteDataSource.updateUserRole(userId, role);

  @override
  Future<void> addProduct(ProductModel product) => remoteDataSource.addProduct(product);

  @override
  Future<void> updateProduct(ProductModel product) => remoteDataSource.updateProduct(product);

  @override
  Future<void> deleteProduct(String productId) => remoteDataSource.deleteProduct(productId);

  @override
  Future<Map<String, dynamic>> getAnalytics() => remoteDataSource.getAnalytics();
}
