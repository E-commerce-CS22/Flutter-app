import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/card/product_card_all.dart';
import '../../../products/presentation/pages/product_screen.dart';
import '../blocs/list_products_cubit.dart';
import '../blocs/list_products_state.dart';

class ListProductsPage extends StatelessWidget {
  const ListProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListProductsCubit()..fetchListProducts(25),
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('كل المنتجات'),
          fontSize: 30,
        ),
        body: BlocBuilder<ListProductsCubit, ListProductsState>(
          builder: (context, state) {
            if (state is ListProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ListProductsLoaded) {
              final products = state.products;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ListProductsCubit>().fetchListProducts(25);
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(13.0), // ✅ هنا نضع البادينج بدلًا من الأعلى
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCardForAll(
                      productId: product.id,
                      name: product.name,
                      price: product.price,
                      imageUrl: product.image,
                      onTap: () {
                        AppNavigator.push(
                          context,
                          ProductScreen(productId: product.id),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is ListProductsError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            }
            return const Center(child: Text('لا توجد منتجات'));
          },
        ),
      ),
    );
  }
}
