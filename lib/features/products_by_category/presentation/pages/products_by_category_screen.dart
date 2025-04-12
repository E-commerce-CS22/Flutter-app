import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/products_by_category/presentation/pages/widgets/product_card.dart';
import '../../../products/presentation/pages/product_details_screen.dart';
import '../../../products/presentation/pages/product_screen.dart';
import '../blocs/get_product_by_category_state.dart';
import '../blocs/get_product_by_cateogry_cubit.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final int categoryId;
  final int pageId;
  final String categoryName;

  const ProductsByCategoryScreen({
    super.key,
    required this.categoryId,
    this.pageId = 1,
    required this.categoryName,
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
      appBar: CurvedAppBar(
        title: Text(widget.categoryName),
        fontSize: 20,
        height: 100,
      ),
      body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
        builder: (context, state) {
          if (state is ProductsByCategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsByCategoryError) {
            return Center(child: Text('خطأ: ${state.message}'));
          } else if (state is ProductsByCategoryLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.products.products.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = state.products.products.products[index];

                return ProductCard(
                  name: product.name,
                  price: product.price,
                  imageUrl: product.primaryImage,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(productId: product.id),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: Text('لا توجد منتجات متاحة'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProductsByCategoryCubit>().fetchProductsByCategory(widget.categoryId, widget.pageId);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
