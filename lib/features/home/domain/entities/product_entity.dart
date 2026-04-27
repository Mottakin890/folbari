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
}
