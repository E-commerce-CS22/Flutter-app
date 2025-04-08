import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/orders_cubit.dart';
import '../blocs/orders_state.dart';
import 'specific_order_page.dart';
import '../blocs/specific_order_cubit.dart'; // ضروري

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..fetchOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('الطلبات'),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OrdersError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            } else if (state is OrdersLoaded) {
              final orders = state.orders;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text('طلب رقم ${order.id}'),
                    subtitle: Text('المبلغ الإجمالي: ${order.totalAmount}'),
                    trailing: Text(order.status),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => OrderCubit(),
                            child: SpecificOrderPage(orderId: order.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(child: Text('لا توجد بيانات'));
          },
        ),
      ),
    );
  }
}
