import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
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

                return GestureDetector(
                  onTap: () {
                    // التنقل إلى صفحة تفاصيل المنتج عند الضغط
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => ProductDetailsPage(productId: product.id), // تمرير معرف المنتج
                        builder: (context) => ProductScreen(productId: product.id), // تمرير معرف المنتج

                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 180,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            product.primaryImage != null && product.primaryImage!.isNotEmpty
                                ? Image.network(
                              product.primaryImage!,
                              width: 90,
                              height: 90,
                            )
                                : const Icon(Icons.image_not_supported, size: 90),
                            const SizedBox(height: 10),

                            // العنوان
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                            ),

                            const Spacer(),

                            // السعر والالوان في الأسفل
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${product.price} ريال",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      2,
                                          (cindex) => Container(
                                        height: 10,
                                        width: 10,
                                        margin: const EdgeInsets.only(left: 3),
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // أيقونة القلب
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
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
