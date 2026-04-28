class AddressEntity {
  final String id;
  final String label;
  final String fullAddress;
  final String city;
  final String? postalCode;
  final bool isDefault;
  final DateTime createdAt;

  const AddressEntity({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.city,
    this.postalCode,
    this.isDefault = false,
    required this.createdAt,
  });
}
