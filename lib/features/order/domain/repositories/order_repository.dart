import 'package:folbari/features/order/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrders();
  Future<void> placeOrder(OrderEntity order);
}
