import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/categories/presentation/blocs/category_cubit.dart';
import 'package:smartstore/features/categories/presentation/blocs/category_state.dart';
import 'package:smartstore/features/products_by_category/presentation/pages/products_by_category_screen.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsByCategoryScreen(
                              categoryId: category.id,
                              categoryName: category.name,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: category.image != null && category.image!.isNotEmpty
                              ? DecorationImage(
                            image: NetworkImage(category.image!),
                            fit: BoxFit.cover,
                          )
                              : null,
                          color: Colors.grey[300], // لون خلفي عند غياب الصورة
                        ),
                        child: category.image == null || category.image!.isEmpty
                            ? const Icon(Icons.image_not_supported)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            );
          } else if (state is LoadCategoryFailure) {
            return Center(
              child: Text(
                'خطأ: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }
        },
      ),
    );
  }
}
