import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/card/product_card_all.dart';
import 'package:smartstore/features/products_by_category/presentation/pages/widgets/product_card.dart';
import 'package:smartstore/features/search/presentation/blocs/search_cubit.dart';
import 'package:smartstore/features/search/presentation/blocs/search_state.dart';

import '../../../products/presentation/pages/product_screen.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // لإدارة الفوكس
  final int _page = 1;

  @override
  void initState() {
    super.initState();
    // طلب الفوكس لحقل البحث
    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose(); // تنظيف الفوكس نود
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // خلفية بيضاء
        automaticallyImplyLeading: false, // يحذف زر الرجوع
        toolbarHeight: 10, // ارتفاع الـ AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              focusNode: _focusNode,
              // ربط الفوكس نود
              controller: _controller,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                filled: true,
                hintText: 'ابحث عن منتج...',
                hintTextDirection: TextDirection.rtl,
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 20),
              ),
              onChanged: (value) {
                final keyword = value.trim();
                if (keyword.isNotEmpty) {
                  context.read<SearchCubit>().fetchSearch(keyword, _page);
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (state is SearchLoaded) {
                    final products = state.products.products;


                    if (products.isEmpty) {
                      return const Center(child: Text('لم يتم العثور على نتائج لهذا البحث.'));
                    }

                    return GridView.builder(
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
                  }                  else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('...اكتب كلمة للبحث'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



}

