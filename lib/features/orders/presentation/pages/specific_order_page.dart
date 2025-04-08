import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cancel_order_cubit.dart';
import '../blocs/cancel_order_state.dart';
import '../blocs/specific_order_cubit.dart';
import '../blocs/specific_order_state.dart';

class SpecificOrderPage extends StatelessWidget {
  final int orderId;

  SpecificOrderPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    // قم بتحميل الطلب المحدد عند فتح الصفحة
    context.read<OrderCubit>().fetchSpecificOrder(orderId);

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الطلب $orderId'),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrderError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          } else if (state is OrderLoaded) {
            final order = state.order[0]; // نعرض أول عنصر بما أنه طلب واحد فقط
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("الرقم المرجعي: ${order.id}"),
                  SizedBox(height: 8),
                  Text("المجموع الكلي: ${order.totalAmount}"),
                  SizedBox(height: 8),
                  Text("الحالة: ${order.status}"),
                  SizedBox(height: 8),
                  Text("طريقة الدفع: ${order.paymentMethod}"),
                  SizedBox(height: 8),
                  Text("العنوان: ${order.shippingAddress}"),
                  SizedBox(height: 8),
                  if (order.notes != null) ...[
                    Text("ملاحظات: ${order.notes}"),
                    SizedBox(height: 8),
                  ],
                  Text("تاريخ الإنشاء: ${order.createdAt}"),
                  SizedBox(height: 16),
                  Text("تفاصيل المنتجات:"),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text("الكمية: ${item.quantity}, السعر: ${item
                            .unitPrice}"),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // طلب إلغاء الطلب باستخدام Cubit
                      context.read<CancelOrderCubit>().cancelOrder(order.id);
                    },
                    child: Text('إلغاء الطلب'),
                  ),

                  BlocListener<CancelOrderCubit, CancelOrderState>(
                      listener: (context, cancelState) {
                        if (cancelState is CancelOrderSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('تم إلغاء الطلب بنجاح'),
                            backgroundColor: Colors.green,
                          ));
                        } else if (cancelState is CancelOrderFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'فشل في إلغاء الطلب: ${cancelState.message}'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Container(),
                    ),
                ],
              ),
            );
          }
          return Center(child: Text("لا توجد بيانات"));
        },
      ),
    );
  }
}
