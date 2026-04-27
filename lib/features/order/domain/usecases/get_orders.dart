import 'package:folbari/features/order/domain/entities/order_entity.dart';
import 'package:folbari/features/order/domain/repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders(this.repository);

  Future<List<OrderEntity>> call() async {
    return await repository.getOrders();
  }
}
