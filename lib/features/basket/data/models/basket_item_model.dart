import 'package:folbari/features/basket/domain/entities/basket_item_entity.dart';

class BasketItemModel extends BasketItemEntity {
  const BasketItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productPrice,
    required super.productImage,
    required super.quantity,
  });

  factory BasketItemModel.fromJson(Map<String, dynamic> json) {
    return BasketItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      productPrice: json['product_price'] as String,
      productImage: json['product_image'] as String,
      quantity: json['quantity'] as int,
    );
  }

  factory BasketItemModel.fromEntity(BasketItemEntity entity) {
    return BasketItemModel(
      id: entity.id,
      productId: entity.productId,
      productName: entity.productName,
      productPrice: entity.productPrice,
      productImage: entity.productImage,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'product_image': productImage,
      'quantity': quantity,
    };
  }
}
