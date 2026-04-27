import 'package:folbari/features/order/data/datasources/order_remote_data_source.dart';
import 'package:folbari/features/order/domain/entities/order_entity.dart';
import 'package:folbari/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<OrderEntity>> getOrders() async {
    return await remoteDataSource.getOrders();
  }

  @override
  Future<void> placeOrder(OrderEntity order) async {
    // Implementation for placing order
  }
}
