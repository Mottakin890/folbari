import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:folbari/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdminRemoteDataSource {
  Future<List<ProfileModel>> getAllUsers();
  Future<void> deleteUser(String userId);
  Future<void> updateUserRole(String userId, String role);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
  Future<Map<String, dynamic>> getAnalytics();
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final SupabaseClient supabaseClient;

  AdminRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<ProfileModel>> getAllUsers() async {
    final response = await supabaseClient.from('profiles').select();
    return (response as List).map((e) => ProfileModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteUser(String userId) async {
    // Note: Deleting from profiles might need a database function or service role 
    // because auth.users is protected. We'll assume the profiles delete triggers 
    // something or we just manage profile status.
    await supabaseClient.from('profiles').delete().eq('id', userId);
  }

  @override
  Future<void> updateUserRole(String userId, String role) async {
    await supabaseClient.from('profiles').update({'role': role}).eq('id', userId);
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    await supabaseClient.from('products').insert(product.toJson());
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await supabaseClient.from('products').update(product.toJson()).eq('id', product.id);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await supabaseClient.from('products').delete().eq('id', productId);
  }

  @override
  Future<Map<String, dynamic>> getAnalytics() async {
    // This would typically involve multiple queries or a RPC call
    final userCount = await supabaseClient.from('profiles').select('id');
    final productCount = await supabaseClient.from('products').select('id');
    final orderCount = await supabaseClient.from('orders').select('id');
    
    // Summing revenue (assuming total_amount is numeric or can be summed)
    final orders = await supabaseClient.from('orders').select('total_amount');
    double totalRevenue = 0;
    for (var order in orders) {
       totalRevenue += double.tryParse(order['total_amount'].toString().replaceAll(',', '')) ?? 0;
    }

    return {
      'total_users': userCount.length,
      'total_products': productCount.length,
      'total_orders': orderCount.length,
      'total_revenue': totalRevenue,
    };
  }
}
