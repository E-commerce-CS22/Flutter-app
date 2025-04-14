import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/categories.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/home_slider.dart';
import 'package:smartstore/features/home/presentation/pages/Home/widgets/search_box.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_cubit.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_state.dart';
import 'package:smartstore/features/sliders/domain/entities/sliders_entity.dart';

import '../../../../list_products/domain/entities/list_products_entity.dart';
import '../../../../list_products/presentation/blocs/list_products_cubit.dart';
import '../../../../list_products/presentation/blocs/list_products_state.dart';
import '../../../../list_products/presentation/pages/list_products_screen.dart';
import '../../../../list_products/presentation/pages/widgets/product_card.dart';
import 'models/product.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SlidersCubit()..fetchSliders(),
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('الرئيسية'),
          fontSize: 30,
        ),
        body: BlocBuilder<SlidersCubit, SlidersState>(
          builder: (context, state) {
            List<SlideEntity> slides = [];

            if (state is SlidersLoaded) {
              slides = state.sliders;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SearchBox(),
                    const SizedBox(height: 20),

                    /// ✅ تمرير الصور إلى الـ HomeSlider
                    HomeSlider(
                      slides: slides,
                      currentSlide: currentSlide,
                      onChange: (value) {
                        setState(() {
                          currentSlide = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    const Categories(),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            AppNavigator.push(context, ListProductsPage());

                          },
                          child: const Text("عرض المزيد"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[600],
                          ),
                        ),
                        const Text(
                          "اخترنا لك",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // بناء GridView للمحتوى
                    BlocBuilder<ListProductsCubit, ListProductsState>(
                      builder: (context, state) {
                        if (state is ListProductsLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ListProductsLoaded) {
                          List<ListProductsEntity> products = state.products;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                productId: products[index].id,
                                name: products[index].name,
                                price: products[index].price,
                                imageUrl: products[index].image, // تأكد من الرابط الصحيح للصورة
                                onTap: () {
                                  // يمكنك تنفيذ أي إجراء عند النقر على المنتج
                                },
                              );
                            },
                          );
                        } else if (state is ListProductsError) {
                          return Center(child: Text('Error: ${state.message}'));
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}