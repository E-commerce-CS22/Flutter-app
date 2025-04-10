import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';

import '../blocs/get_product_by_category_state.dart';
import '../blocs/get_product_by_cateogry_cubit.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final int categoryId;
  final int pageId;

  const ProductsByCategoryScreen({
    super.key,
    required this.categoryId,
    this.pageId = 1,
  });

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsByCategoryCubit>().fetchProductsByCategory(widget.categoryId, widget.pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products By Category'),
      ),
      body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
        builder: (context, state) {
          if (state is ProductsByCategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductsByCategoryError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProductsByCategoryLoaded) {
            return ListView.builder(
              itemCount: state.products.products.products.length,
              itemBuilder: (context, index) {
                final product = state.products.products.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toString()}'),
                  leading: product.primaryImage != null && product.primaryImage!.isNotEmpty
                      ? Image.network(product.primaryImage!)
                      : const Icon(Icons.image_not_supported),
                );

              },
            );
          }
          return Center(child: Text('No products available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // عند الضغط على الزر، سيتم إعادة تحميل المنتجات
          context.read<ProductsByCategoryCubit>().fetchProductsByCategory(
              6, 1);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
