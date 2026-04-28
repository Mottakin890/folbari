class OrderEntity {
  final String id;
  final DateTime date;
  final double totalPrice;
  final String
  status; // e.g., 'pending', 'confirmed', 'shipped', 'delivered', 'cancelled'
  final List<String> itemNames;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingPostalCode;
  final String? phone;

  const OrderEntity({
    required this.id,
    required this.date,
    required this.totalPrice,
    required this.status,
    required this.itemNames,
    this.shippingAddress,
    this.shippingCity,
    this.shippingPostalCode,
    this.phone,
  });
}
