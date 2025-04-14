import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/add_to_cart.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/appbar.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/image_slider.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/information.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/product_desc.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../cart/presentation/pages/blocs/cart_cubit.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';
import '../../domain/entities/product_details_entity.dart';
import '../bloc/get_product_details_cubit.dart';
import '../bloc/get_product_details_state.dart';

import 'package:flutter/material.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart'; // Make sure to import your app colors

class ProductScreen extends StatefulWidget {
  final int productId;

  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentImage = 0;
  int currentColor = 0;
  int currentNumber = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit()..fetchProductDetails(widget.productId),
      child: Scaffold(
        backgroundColor: kcontentColor,
        floatingActionButton: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemAddedState) {
              context.read<CartCubit>().getCartItems();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text(
                    'تمت الإضافة بنجاح',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  content: const Text(
                    'هل تريد الانتقال إلى السلة؟',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'لا',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        AppNavigator.push(context, const CartScreen());
                      },
                      child: const Text(
                        'نعم',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.isNotEmpty ? state.message : 'حدث خطأ أثناء إضافة المنتج للسلة',
                  ),
                  backgroundColor: Colors.grey[200],
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            return AddToCart(
              currentNumber: currentNumber,
              onAdd: () {
                setState(() {
                  currentNumber++;
                });
              },
              onRemove: () {
                if (currentNumber > 1) {
                  setState(() {
                    currentNumber--;
                  });
                }
              },
              onPressed: () {
                context.read<CartCubit>().addProductToCart(widget.productId, currentNumber);
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ProductAppBar(productId: product.id),
                      ImageSlider(
                        onChange: (index) {
                          setState(() {
                            currentImage = index;
                          });
                        },
                        currentImage: currentImage,
                        image: product.image ?? 'assets/images/notFound.jpg',
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: currentImage == index ? 15 : 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              color: currentImage == index ? Colors.black : Colors.transparent,
                            ),
                          ),
                        ).reversed.toList(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ProductInfo(product: product),
                            const SizedBox(height: 20),
                            ///////////////////////////////////////

                            const Text(
                              ':الخيارات',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Use Wrap for variant buttons
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              // reverse: true,
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: product.variants.map((variant) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentColor = product.variants.indexOf(variant);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: currentColor == product.variants.indexOf(variant) ? AppColors.primary : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: currentColor == product.variants.indexOf(variant) ? AppColors.primary : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        variant.variantTitle ?? 'غير متوفر',
                                        style: TextStyle(
                                          color: currentColor == product.variants.indexOf(variant) ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              ':المواصفات',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Use Card for each attribute for a modern look
                            ...product.variants[currentColor].attributes.map((attribute) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.shade300), // Subtle border
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      attribute.value.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      attribute.attribute.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.black,
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 20),
                            ProductDescription(text: product.description),
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox(); // Initial state
          },
        ),
      ),
    );
  }
}
