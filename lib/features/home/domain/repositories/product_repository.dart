import 'package:folbari/features/home/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getRecommendedProducts();
  Future<List<ProductEntity>> getCategoryProducts();
}
