import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/cart/presentation/pages/widgets/cart_tile.dart';
import 'package:smartstore/features/cart/presentation/pages/widgets/check_out_box.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';
import '../models/cart_item.dart';
import 'blocs/cart_cubit.dart'; // إضافة ملف الـ cubit

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartItems(), // توفير الـ cubit
      child: Scaffold(
        backgroundColor: kcontentColor,
        appBar: const CurvedAppBar(
          title: Text('السلة'),
          fontSize: 30,
        ),
        // bottomSheet: BlocBuilder<CartCubit, CartState>(
        //   builder: (context, state) {
        //     if (state is CartLoaded) {
        //       return CheckOutBox(
        //         items: state.cartItems,
        //       );
        //     }
        //     return SizedBox(); // عرض مساحة فارغة إذا لم يتم تحميل البيانات
        //   },
        // ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل
            } else if (state is CartLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) => CartTile(
                  item: state.cartItems[index],
                  // onRemove: () {
                  //   if (state.cartItems[index].quantity != 1) {
                  //     context.read<CartCubit>().updateQuantity(state.cartItems[index].id, -1);
                  //   }
                  // },
                  // onAdd: () {
                  //   context.read<CartCubit>().updateQuantity(state.cartItems[index].id, 1);
                  // },
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 20),
              );
            } else if (state is CartError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is CartItemDeleted){
              context.read<CartCubit>().getCartItems(); // إعادة تحميل السلة بعد الحذف
            }
            return const SizedBox(); // حالة فارغة قبل تحميل البيانات
          },
        ),
      ),
    );
  }
}


// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CartCubit()..getCartItems(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Cart')),
//         body: BlocBuilder<CartCubit, CartState>(
//           builder: (context, state) {
//             print("🔄 UI state: $state");
//             if (state is CartLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is CartLoaded) {
//               return ListView.builder(
//                 itemCount: state.cartItems.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(state.cartItems[index].name),
//                     subtitle: Text(state.cartItems[index].description),
//                     trailing: Text('Price: \$${state.cartItems[index].price}'),
//                   );
//                 },
//               );
//             } else if (state is CartError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }
//             return Container(); // حالة ابتدائية فارغة
//           },
//         ),
//       ),
//     );
//   }
// }
