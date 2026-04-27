import 'package:folbari/features/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.date,
    required super.totalPrice,
    required super.status,
    required super.itemNames,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      date: DateTime.parse(json['created_at'] as String),
      totalPrice: (json['total_price'] as num).toDouble(),
      status: json['status'] as String,
      itemNames: List<String>.from(json['item_names'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': date.toIso8601String(),
      'total_price': totalPrice,
      'status': status,
      'item_names': itemNames,
    };
  }
}
