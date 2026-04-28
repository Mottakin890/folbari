import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:folbari/features/profile/data/models/profile_model.dart';

abstract class AdminRepository {
  Future<List<ProfileModel>> getAllUsers();
  Future<void> deleteUser(String userId);
  Future<void> updateUserRole(String userId, String role);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<Map<String, dynamic>> getAnalytics();
}
