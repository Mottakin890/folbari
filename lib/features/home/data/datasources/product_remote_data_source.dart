import 'package:folbari/core/resources/app_assets.dart';
import 'package:folbari/core/utils/logger.dart';
import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getRecommendedProducts();
  Future<List<ProductModel>> getCategoryProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProductRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<ProductModel>> getRecommendedProducts() async {
    logger.i('Fetching recommended products...');
    // In a real app, you would fetch from Supabase:
    // final response = await supabaseClient.from('products').select().eq('type', 'recommended');
    // return response.map((data) => ProductModel.fromJson(data)).toList();
    
    // For now, mock the response but keep the structure
    await Future.delayed(const Duration(milliseconds: 500));
    final products = [
      const ProductModel(
        id: '1',
        name: 'Honey lime combo',
        price: '2,000',
        image: AppAssets.product_1,
        description:
            'If you are looking for a new fruit salad to eat today, honey lime is the perfect brunch for you.',
        ingredients: 'Honey, Lime, Blueberries, Strawberries, Mango, Fresh mint.',
      ),
      const ProductModel(
        id: '2',
        name: 'Berry mango combo',
        price: '8,000',
        image: AppAssets.product_2,
        description:
            'If you are looking for a new fruit salad to eat today, berry mango is the perfect brunch for you.',
        ingredients: 'Blueberries, Mango, Honey, Fresh mint.',
      ),
      const ProductModel(
        id: '3',
        name: 'Quinoa fruit salad',
        price: '10,000',
        image: AppAssets.product_3,
        description:
            'If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you. make',
        ingredients: 'Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.',
      ),
    ];
    logger.d('Fetched ${products.length} recommended products');
    return products;
  }

  @override
  Future<List<ProductModel>> getCategoryProducts() async {
    logger.i('Fetching category products...');
    await Future.delayed(const Duration(milliseconds: 500));
    final products = [
      const ProductModel(
        id: '4',
        name: 'Quinoa fruit salad',
        price: '10,000',
        image: AppAssets.product_4,
        description:
            'If you are looking for a new fruit salad to eat today, quinoa is the perfect brunch for you.',
        ingredients: 'Red Quinoa, Lime, Honey, Blueberries, Strawberries, Mango, Fresh mint.',
      ),
      const ProductModel(
        id: '5',
        name: 'Tropical fruit salad',
        price: '10,000',
        image: AppAssets.product_1,
        description:
            'If you are looking for a new fruit salad to eat today, tropical is the perfect brunch for you.',
        ingredients: 'Mango, Pineapple, Papaya, Lime, Fresh mint.',
      ),
      const ProductModel(
        id: '1',
        name: 'Melon fruit salad',
        price: '10,000',
        image: AppAssets.product_5,
        description:
            'If you are looking for a new fruit salad to eat today, melon is the perfect brunch for you.',
        ingredients: 'Watermelon, Cantaloupe, Honeydew, Fresh mint.',
      ),
    ];
    logger.d('Fetched ${products.length} category products');
    return products;
  }
}
