class ProductEntity {
  final String id;
  final String name;
  final String price;
  final String image;
  final String? description;
  final String? ingredients;
  final bool isFavorite;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.description,
    this.ingredients,
    this.isFavorite = false,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? price,
    String? image,
    String? description,
    String? ingredients,
    bool? isFavorite,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
