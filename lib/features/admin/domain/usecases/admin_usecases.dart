import 'package:folbari/features/admin/domain/repositories/admin_repository.dart';
import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:folbari/features/profile/data/models/profile_model.dart';

class GetAllUsers {
  final AdminRepository repository;
  GetAllUsers(this.repository);
  Future<List<ProfileModel>> call() => repository.getAllUsers();
}

class DeleteUser {
  final AdminRepository repository;
  DeleteUser(this.repository);
  Future<void> call(String userId) => repository.deleteUser(userId);
}

class UpdateUserRole {
  final AdminRepository repository;
  UpdateUserRole(this.repository);
  Future<void> call(String userId, String role) => repository.updateUserRole(userId, role);
}

class AddProduct {
  final AdminRepository repository;
  AddProduct(this.repository);
  Future<void> call(ProductModel product) => repository.addProduct(product);
}

class UpdateProduct {
  final AdminRepository repository;
  UpdateProduct(this.repository);
  Future<void> call(ProductModel product) => repository.updateProduct(product);
}

class DeleteProduct {
  final AdminRepository repository;
  DeleteProduct(this.repository);
  Future<void> call(String productId) => repository.deleteProduct(productId);
}

class GetAnalytics {
  final AdminRepository repository;
  GetAnalytics(this.repository);
  Future<Map<String, dynamic>> call() => repository.getAnalytics();
}
