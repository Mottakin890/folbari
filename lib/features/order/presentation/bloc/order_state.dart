import 'package:equatable/equatable.dart';
import 'package:folbari/features/order/domain/entities/order_entity.dart';

enum OrderStatus { initial, loading, loaded, error }

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderEntity> orders;
  final String? errorMessage;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders = const [],
    this.errorMessage,
  });

  bool get isLoading => status == OrderStatus.loading;
  bool get isLoaded => status == OrderStatus.loaded;
  bool get isError => status == OrderStatus.error;

  OrderState copyWith({
    OrderStatus? status,
    List<OrderEntity>? orders,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, orders, errorMessage];
}
