import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

import '../blocs/category_cubit.dart';
import '../blocs/category_state.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('الفئات'),
          fontSize: 30,
        ),
        body: SingleChildScrollView(  // Wrap the whole body in a SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shopByCategories(),
                const SizedBox(height: 10),
                _categoriesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return const Text(
      'تسوق حسب الفئات',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }

  Widget _categoriesList() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),  // Prevent scrolling in ListView
            shrinkWrap: true,  // Allow ListView to occupy its own height
            itemBuilder: (context, index) {
              var category = state.categories[index];
              return Container(
                height: 70,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: category.image != null
                            ? DecorationImage(
                          image: NetworkImage(category.image!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: category.image == null
                          ? const Icon(Icons.image_not_supported, color: Colors.grey)
                          : null,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: state.categories.length,
          );
        } else if (state is LoadCategoryFailure) {
          return Center(child: Text('خطأ: ${state.errorMessage}', style: const TextStyle(color: Colors.red)));
        } else {
          return const Center(child: Text('لا توجد بيانات متاحة'));
        }
      },
    );
  }
}
