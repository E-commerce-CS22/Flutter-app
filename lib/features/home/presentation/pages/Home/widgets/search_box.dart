import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/helper/navigator/app_navigator.dart';
import '../../../../../ai/ai_page.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: TextDirection.rtl, // Set text direction to RTL
      decoration: InputDecoration(
        filled: true,
        // fillColor: Colors.grey[200],
        hintText: 'ابحث عن منتج...', // Arabic for "Search for a product..."
        hintTextDirection: TextDirection.rtl, // Hint text direction RTL
        suffixIcon: const Icon(Icons.search, color: Colors.grey), // Move icon to the right
        prefixIcon: GestureDetector(
            onTap: (){
              AppNavigator.push(context, ChatPage());
            },
            child: const Icon(Icons.smart_toy_outlined, color: Colors.grey)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      onChanged: (value) {
        // Handle search logic here
      },
    );
  }
}