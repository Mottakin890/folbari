class BasketItemEntity {
  final String id;
  final String productId;
  final String productName;
  final String productPrice;
  final String productImage;
  final int quantity;

  const BasketItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
  });
}
