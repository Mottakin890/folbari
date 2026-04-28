import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_event.dart';
import 'package:folbari/features/home/data/models/product_model.dart';
import 'package:folbari/features/home/presentation/bloc/product_bloc.dart';
import 'package:folbari/features/home/presentation/bloc/product_state.dart';

class ProductManagerScreen extends StatelessWidget {
  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        backgroundColor: AppColors.cFFA451,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ProductStatus.loaded) {
            final allProducts = [...state.recommendedProducts, ...state.categoryProducts];
            return ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                final product = allProducts[index] as ProductModel;
                return ListTile(
                  leading: Image.network(product.image, width: 50, errorBuilder: (_, _, _) => const Icon(Icons.image)),
                  title: Text(product.name),
                  subtitle: Text('₦${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showProductDialog(context, product: product),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => context.read<AdminBloc>().add(AdminDeleteProduct(product.id)),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No products found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cFFA451,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _showProductDialog(context),
      ),
    );
  }

  void _showProductDialog(BuildContext context, {ProductModel? product}) {
    final nameController = TextEditingController(text: product?.name);
    final priceController = TextEditingController(text: product?.price);
    final imageController = TextEditingController(text: product?.image);
    final descController = TextEditingController(text: product?.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price')),
              TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Image URL')),
              TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final newProduct = ProductModel(
                id: product?.id ?? '',
                name: nameController.text,
                price: priceController.text,
                image: imageController.text,
                description: descController.text,
              );
              if (product == null) {
                context.read<AdminBloc>().add(AdminAddProduct(newProduct));
              } else {
                context.read<AdminBloc>().add(AdminUpdateProduct(newProduct));
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
