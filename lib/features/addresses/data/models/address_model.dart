import 'package:folbari/features/addresses/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.label,
    required super.fullAddress,
    required super.city,
    super.postalCode,
    super.isDefault,
    required super.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      label: json['label'] as String,
      fullAddress: json['full_address'] as String,
      city: json['city'] as String,
      postalCode: json['postal_code'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'full_address': fullAddress,
      'city': city,
      'postal_code': postalCode,
      'is_default': isDefault,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
