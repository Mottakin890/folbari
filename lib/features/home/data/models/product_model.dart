import 'package:folbari/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    super.description,
    super.ingredients,
    super.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
      description: json['description'] as String?,
      ingredients: json['ingredients'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'ingredients': ingredients,
      'is_favorite': isFavorite,
    };
  }
}
