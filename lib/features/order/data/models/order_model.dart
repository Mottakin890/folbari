import 'package:folbari/features/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.date,
    required super.totalPrice,
    required super.status,
    required super.itemNames,
    super.shippingAddress,
    super.shippingCity,
    super.shippingPostalCode,
    super.phone,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      date: DateTime.parse(json['created_at'] as String),
      totalPrice:
          double.tryParse(
            (json['total_amount'] as String?)?.replaceAll(',', '') ?? '0',
          ) ??
          0.0,
      status: json['status'] as String,
      itemNames: json['item_names'] != null
          ? List<String>.from(json['item_names'] as List)
          : [],
      shippingAddress: json['shipping_address'] as String?,
      shippingCity: json['shipping_city'] as String?,
      shippingPostalCode: json['shipping_postal_code'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': date.toIso8601String(),
      'total_amount': totalPrice.toString(),
      'status': status,
      'item_names': itemNames,
      'shipping_address': shippingAddress,
      'shipping_city': shippingCity,
      'shipping_postal_code': shippingPostalCode,
      'phone': phone,
    };
  }
}
