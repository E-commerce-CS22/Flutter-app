import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../blocs/cancel_order_cubit.dart';
import '../blocs/cancel_order_state.dart';
import '../blocs/specific_order_cubit.dart';
import '../blocs/specific_order_state.dart';


class SpecificOrderPage extends StatelessWidget {
  final int orderId;

  const SpecificOrderPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().fetchSpecificOrder(orderId);

    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text('تفاصيل الطلب'),
        fontSize: 30,
      ),
      backgroundColor: Colors.white, // تأكيد أن الخلفية بيضاء
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          } else if (state is OrderLoaded) {
            final order = state.order[0];
            final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildOrderDetailsCard(order, formattedDate),
                  const SizedBox(height: 20),
                  _buildProductsCard(order),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CancelOrderCubit>().cancelOrder(order.id);
                    },
                    icon: const Icon(Icons.cancel, color: Colors.white), // لون أيقونة الإلغاء أبيض
                    label: const Text('إلغاء الطلب', style: TextStyle(color: Colors.white)), // لون نص الإلغاء أبيض
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300], // لون أحمر باهت للإلغاء
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocListener<CancelOrderCubit, CancelOrderState>(
                    listener: (context, cancelState) {
                      if (cancelState is CancelOrderSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('تم إلغاء الطلب بنجاح', style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.green[400],
                          ),
                        );
                      } else if (cancelState is CancelOrderFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('فشل في إلغاء الطلب: ${cancelState.message}', style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red[400],
                          ),
                        );
                      }
                    },
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text("لا توجد بيانات"));
        },
      ),
    );
  }

  Widget _buildOrderDetailsCard(order, String formattedDate) {
    return Card(
      elevation: 2,
      color: Colors.grey[100], // لون رمادي فاتح
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // محاذاة العناصر لليمين
          children: [
            _infoRow('رقم الطلب:', order.id.toString()),
            _infoRow('المجموع:', '${order.totalAmount} ريال'),
            _infoRow('الحالة:', order.status),
            _infoRow('طريقة الدفع:', order.paymentMethod),
            _infoRow('العنوان:', order.shippingAddress),
            if (order.notes != null && order.notes!.isNotEmpty)
              _infoRow('ملاحظات:', order.notes!),
            _infoRow('تاريخ الإنشاء:', formattedDate),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsCard(order) {
    return Card(
      elevation: 2,
      color: Colors.grey[100], // لون رمادي فاتح
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // محاذاة العناصر لليمين
          children: [
            const Text(
              "تفاصيل المنتجات:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87), // لون نص أغمق
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              separatorBuilder: (_, __) => Divider(color: Colors.grey[300]), // لون فاصل رمادي فاتح جدًا
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(item.product.name, style: const TextStyle(color: Colors.black87))), // لون نص أغمق
                      Text('× ${item.quantity}', style: const TextStyle(color: Colors.black87)), // لون نص أغمق
                      Text('${item.unitPrice} ريال', style: const TextStyle(color: Colors.black87)), // لون نص أغمق
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // محاذاة العناصر لليمين
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), // لون نص أغمق
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(value, style: const TextStyle(color: Colors.black87)), // لون نص أغمق
          ),
        ],
      ),
    );
  }
}
