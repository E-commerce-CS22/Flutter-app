import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/wishlist/presentaion/pages/blocs/wishlist_cubit.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../cart/presentation/models/cart_item.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';
import '../../../products/presentation/pages/product_screen.dart';
import '../widgets/wishlist_tile.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: const CurvedAppBar(
        title: Text('المفضلة'),
        fontSize: 30,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل
          } else if (state is WishlistLoaded) {
            if (state.wishlistItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/wishlist_empty.png', height: 100), // صورة فارغة للمفضلة
                    const SizedBox(height: 20),
                    const Text(
                      'لا توجد عناصر في المفضلة حالياً',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                color: Colors.blue,
                onRefresh: () async {
                  context.read<WishlistCubit>().getWishlists();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) => WishlistTile(
                    item: state.wishlistItems[index],
                    onRemove: () {
                      if (cartItems[index].quantity != 1) {
                        (() {
                          cartItems[index].quantity--;
                        });
                      }
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(productId: state.wishlistItems[index].id),
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemCount: state.wishlistItems.length,
                ),
              );
            }
          } else if (state is WishlistError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is WishlistItemDeleted) {
            context.read<WishlistCubit>().getWishlists();
          }
          return const SizedBox(); // حالة فارغة قبل تحميل البيانات
        },
      ),
    );
  }
}
