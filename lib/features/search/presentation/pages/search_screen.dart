import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/search/presentation/blocs/search_cubit.dart';
import 'package:smartstore/features/search/presentation/blocs/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter search keyword...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final keyword = _controller.text.trim();
                if (keyword.isNotEmpty) {
                  context.read<SearchCubit>().fetchSearch(keyword, _page);
                }
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.products.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products.products[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('Price: \$${product.price}'),
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Enter a keyword to search.'));
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
