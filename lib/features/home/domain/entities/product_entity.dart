import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String price;
  final String image;
  final bool isFavorite;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, name, price, image, isFavorite];
}
