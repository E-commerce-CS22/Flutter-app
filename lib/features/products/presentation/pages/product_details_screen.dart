import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/products/presentation/bloc/get_product_details_cubit.dart';
import 'package:smartstore/features/products/presentation/bloc/get_product_details_state.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit()..fetchProductDetails(1), // تحميل منتج رقم 1
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل المنتج'),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductDetailsError) {
              return Center(
                child: Text(state.message, style: const TextStyle(color: Colors.red)),
              );
            }

            if (state is ProductDetailsLoaded) {
              final product = state.product;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(product.description),
                    const SizedBox(height: 20),
                    Text('السعر: \$${product.price}', style: const TextStyle(fontSize: 18)),
                    if (product.discountValue != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        'التخفيض: ${product.discountValue} (${product.discountType})',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: product.tags.map((tag) => Chip(label: Text(tag))).toList(),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox(); // للحالة initial
          },
        ),
      ),
    );
  }
}
