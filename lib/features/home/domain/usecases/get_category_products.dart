import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/domain/repositories/product_repository.dart';

class GetCategoryProducts {
  final ProductRepository repository;

  GetCategoryProducts(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getCategoryProducts();
  }
}
