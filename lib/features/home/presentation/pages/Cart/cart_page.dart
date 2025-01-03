import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy cart items for demonstration
    final cartItems = [
      {'name': 'Product 1', 'price': 50.0, 'quantity': 1},
      {'name': 'Product 2', 'price': 30.0, 'quantity': 2},
      {'name': 'Product 3', 'price': 20.0, 'quantity': 3},
    ];

    // Calculate total price
    double totalPrice = cartItems.fold(
      0,
          (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
    );

    return Scaffold(
      appBar: CurvedAppBar(
        title: const Text('السلة'),
        height: 135,
        fontSize: 30,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      item['quantity'].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(item['name'].toString()),
                  subtitle: Text('Price: \$${item['price']}'),
                  trailing: Text('Total: \$${(item['price'] as double) * (item['quantity'] as int)}'),
                );
              },
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(16.0),
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade100,
          //     border: const Border(top: BorderSide(color: Colors.grey)),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Text(
          //         'Total: \$${totalPrice.toStringAsFixed(2)}',
          //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //         textAlign: TextAlign.right,
          //       ),
          //       const SizedBox(height: 16),
          //       ElevatedButton(
          //         onPressed: () {
          //           // Add checkout functionality here
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(content: Text('Checkout not implemented yet')),
          //           );
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.green,
          //           padding: const EdgeInsets.symmetric(vertical: 16),
          //         ),
          //         child: const Text(
          //           'Proceed to Checkout',
          //           style: TextStyle(fontSize: 16),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
