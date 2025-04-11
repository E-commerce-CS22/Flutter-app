import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/add_to_cart.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/appbar.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/image_slider.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/information.dart';
import 'package:smartstore/features/products/presentation/pages/product_widgets/product_desc.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';
import '../../domain/entities/product_details_entity.dart';
import '../bloc/get_product_details_cubit.dart';
import '../bloc/get_product_details_state.dart';

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
        floatingActionButton: AddToCart(
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
                      const ProductAppBar(),
                      ImageSlider(
                        onChange: (index) {
                          setState(() {
                            currentImage = index;
                          });
                        },
                        currentImage: currentImage,
                        image: product.image ?? 'gg',
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5, // يفضل ربط هذا بعدد الصور مستقبلاً
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
                            if (product.colors != null && product.colors!.isNotEmpty) ...[
                              const Text(
                                "اللون",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(
                                  product.colors!.length,
                                      (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentColor = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 35,
                                      height: 35,
                                      margin: const EdgeInsets.only(left: 15),
                                      padding: currentColor == index ? const EdgeInsets.all(2) : null,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: currentColor == index ? Colors.white : product.colors![index],
                                        border: currentColor == index
                                            ? Border.all(color: product.colors![index])
                                            : null,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: product.colors![index],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                            ProductDescription(text: product.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox(); // Initial
          },
        ),
      ),
    );
  }
}
