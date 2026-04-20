import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/domain/repositories/product_repository.dart';

class GetRecommendedProducts {
  final ProductRepository repository;

  GetRecommendedProducts(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getRecommendedProducts();
  }
}
