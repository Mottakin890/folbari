import 'package:folbari/features/order/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<List<OrderModel>> getOrders() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return dummy orders for production-level testing
    return [
      OrderModel(
        id: 'ORD-1234',
        date: DateTime.now().subtract(const Duration(days: 1)),
        totalPrice: 2400,
        status: 'Delivered',
        itemNames: const ['Quinoa fruit salad', 'Melon fruit salad'],
      ),
      OrderModel(
        id: 'ORD-5678',
        date: DateTime.now().subtract(const Duration(hours: 5)),
        totalPrice: 1200,
        status: 'Pending',
        itemNames: const ['Tropical fruit salad'],
      ),
    ];
  }
}
