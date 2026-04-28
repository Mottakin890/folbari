import 'package:folbari/features/order/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel?> getOrderById(String id);
  Future<void> createOrder(OrderModel order, List<Map<String, dynamic>> items);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final SupabaseClient supabaseClient;

  OrderRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return [];

      logger.i('Fetching orders for user: $userId');

      // Get orders
      final ordersResponse = await supabaseClient
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final orders = (ordersResponse as List).map((data) {
        return OrderModel(
          id: data['id'] as String,
          date: DateTime.parse(data['created_at'] as String),
          totalPrice:
              double.tryParse(
                (data['total_amount'] as String).replaceAll(',', ''),
              ) ??
              0.0,
          status: data['status'] as String,
          itemNames: [], // Will be populated from order_items
        );
      }).toList();

      // Get order items for each order
      final ordersWithItems = await Future.wait(
        orders.map((order) async {
          final itemsResponse = await supabaseClient
              .from('order_items')
              .select()
              .eq('order_id', order.id);

          final items = (itemsResponse as List)
              .map((item) => item['product_name'] as String)
              .toList();

          return OrderModel(
            id: order.id,
            date: order.date,
            totalPrice: order.totalPrice,
            status: order.status,
            itemNames: items,
          );
        }),
      );

      logger.d('Fetched ${ordersWithItems.length} orders');
      return ordersWithItems;
    } catch (e) {
      logger.e('Error fetching orders', error: e);
      rethrow;
    }
  }

  @override
  Future<OrderModel?> getOrderById(String id) async {
    try {
      final response = await supabaseClient
          .from('orders')
          .select()
          .eq('id', id)
          .single();

      final itemsResponse = await supabaseClient
          .from('order_items')
          .select()
          .eq('order_id', id);

      final items = (itemsResponse as List)
          .map((item) => item['product_name'] as String)
          .toList();

      return OrderModel(
        id: response['id'] as String,
        date: DateTime.parse(response['created_at'] as String),
        totalPrice:
            double.tryParse(
              (response['total_amount'] as String).replaceAll(',', ''),
            ) ??
            0.0,
        status: response['status'] as String,
        itemNames: items,
      );
    } catch (e) {
      logger.e('Error fetching order by id', error: e);
      rethrow;
    }
  }

  @override
  Future<void> createOrder(
    OrderModel order,
    List<Map<String, dynamic>> items,
  ) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Creating order for user: $userId');

      // Create order
      final orderResponse = await supabaseClient
          .from('orders')
          .insert({
            'user_id': userId,
            'total_amount': order.totalPrice.toString(),
            'status': 'pending',
            'shipping_address': order.shippingAddress,
            'shipping_city': order.shippingCity,
            'shipping_postal_code': order.shippingPostalCode,
            'phone': order.phone,
          })
          .select()
          .single();

      final orderId = orderResponse['id'] as String;

      // Create order items
      for (final item in items) {
        await supabaseClient.from('order_items').insert({
          'order_id': orderId,
          'product_id': item['product_id'],
          'product_name': item['product_name'],
          'product_price': item['product_price'],
          'product_image': item['product_image'],
          'quantity': item['quantity'],
        });
      }

      logger.i('Order created successfully: $orderId');
    } catch (e) {
      logger.e('Error creating order', error: e);
      rethrow;
    }
  }
}
