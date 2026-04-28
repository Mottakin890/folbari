import 'package:equatable/equatable.dart';
import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:folbari/features/profile/data/models/profile_model.dart';

enum AdminStatus { initial, loading, loaded, error }

class AdminState extends Equatable {
  final AdminStatus status;
  final Map<String, dynamic> analytics;
  final List<ProfileModel> users;
  final List<ProductModel> products;
  final String? error;

  const AdminState({
    this.status = AdminStatus.initial,
    this.analytics = const {},
    this.users = const [],
    this.products = const [],
    this.error,
  });

  AdminState copyWith({
    AdminStatus? status,
    Map<String, dynamic>? analytics,
    List<ProfileModel>? users,
    List<ProductModel>? products,
    String? error,
  }) {
    return AdminState(
      status: status ?? this.status,
      analytics: analytics ?? this.analytics,
      users: users ?? this.users,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, analytics, users, products, error];
}
