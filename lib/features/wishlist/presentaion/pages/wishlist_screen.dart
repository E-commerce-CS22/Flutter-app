import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/wishlist/presentaion/pages/blocs/wishlist_cubit.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../cart/presentation/models/cart_item.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';
import '../widgets/wishlist_tile.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: const CurvedAppBar(
        title: Text('المفضلة'),
        // height: 135,
        fontSize: 30,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading){
            return const Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل

          } else if (state is WishlistLoaded){
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) =>
                  WishlistTile(
                    item: state.wishlistItems[index],
                    onRemove: () {
                      if (cartItems[index].quantity != 1) {
                        (() {
                          cartItems[index].quantity--;
                        });
                      }
                    },
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: state.wishlistItems.length,
            );
          } else if (state is WishlistError){
            return Center(child: Text('Error: ${state.message}'));
          }else if (state is WishlistItemDeleted){
            context.read<WishlistCubit>().getWishlists();
          }
          return const SizedBox(); // حالة فارغة قبل تحميل البيانات
        },
      ),
    );
  }
}
