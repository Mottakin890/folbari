import 'package:equatable/equatable.dart';
import 'package:folbari/features/home/data/models/product_model.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class LoadAdminDashboard extends AdminEvent {}

class LoadAllUsers extends AdminEvent {}

class AdminDeleteUser extends AdminEvent {
  final String userId;
  const AdminDeleteUser(this.userId);
  @override
  List<Object?> get props => [userId];
}

class AdminUpdateUserRole extends AdminEvent {
  final String userId;
  final String role;
  const AdminUpdateUserRole(this.userId, this.role);
  @override
  List<Object?> get props => [userId, role];
}

class AdminAddProduct extends AdminEvent {
  final ProductModel product;
  const AdminAddProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class AdminUpdateProduct extends AdminEvent {
  final ProductModel product;
  const AdminUpdateProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class AdminDeleteProduct extends AdminEvent {
  final String productId;
  const AdminDeleteProduct(this.productId);
  @override
  List<Object?> get props => [productId];
}

class LoadAllMessages extends AdminEvent {}
