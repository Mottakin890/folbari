import 'package:folbari/core/utils/logger.dart';
import 'package:folbari/features/home/data/datasources/product_remote_data_source.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';
import 'package:folbari/features/home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getRecommendedProducts() async {
    logger.d('ProductRepository: getRecommendedProducts called');
    return await remoteDataSource.getRecommendedProducts();
  }

  @override
  Future<List<ProductEntity>> getCategoryProducts() async {
    logger.d('ProductRepository: getCategoryProducts called');
    return await remoteDataSource.getCategoryProducts();
  }
}
