class OrderEntity {
  final String id;
  final DateTime date;
  final double totalPrice;
  final String status; // e.g., 'Pending', 'Delivered', 'Cancelled'
  final List<String> itemNames;

  const OrderEntity({
    required this.id,
    required this.date,
    required this.totalPrice,
    required this.status,
    required this.itemNames,
  });
}
