import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/order/domain/usecases/get_orders.dart';
import 'package:folbari/features/order/presentation/bloc/order_event.dart';
import 'package:folbari/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrders getOrders;

  OrderBloc({required this.getOrders}) : super(const OrderState()) {
    on<FetchOrders>(_onFetchOrders);
  }

  Future<void> _onFetchOrders(
    FetchOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final orders = await getOrders();
      emit(state.copyWith(status: OrderStatus.loaded, orders: orders));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.error, errorMessage: e.toString()));
    }
  }
}
