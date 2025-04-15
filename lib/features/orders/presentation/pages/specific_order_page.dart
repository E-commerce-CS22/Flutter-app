import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartstore/features/orders/presentation/blocs/orders_cubit.dart';

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
      backgroundColor: Colors.white,
      body: BlocListener<CancelOrderCubit, CancelOrderState>(
        listener: (context, cancelState) {
          if (cancelState is CancelOrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم إلغاء الطلب بنجاح', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.grey[400],
              ),
            );
            // ✅ إعادة تحميل تفاصيل الطلب بعد الإلغاء
            context.read<OrderCubit>().fetchSpecificOrder(orderId);
          } else if (cancelState is CancelOrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('فشل في إلغاء الطلب: ${cancelState.message}', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red[400],
              ),
            );
          }
        },
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            } else if (state is OrderLoaded) {
              final order = state.order[0];
              final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderDetailsCard(order, formattedDate),
                    const SizedBox(height: 20),
                    _buildProductsCard(order),
                    const SizedBox(height: 20),
                    if (order.status.toLowerCase() == 'pending')
                      Center(child: _buildCancelOrderButton(context, order)),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }
            return const Center(child: Text("لا توجد بيانات"));
          },
        ),
      ),
    );
  }

  Widget _buildOrderDetailsCard(order, String formattedDate) {
    return Card(
      elevation: 3,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow('رقم الطلب:', order.id.toString()),
            _infoRow('المجموع:', '${order.totalAmount} ريال'),
            _coloredStatusRow(order.status),
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
      elevation: 3,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "تفاصيل المنتجات:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(item.product.name, style: const TextStyle(color: Colors.black87))),
                      Text('× ${item.quantity}', style: const TextStyle(color: Colors.black87)),
                      Text('${item.unitPrice} ريال', style: const TextStyle(color: Colors.black87)),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
          Text(value, style: const TextStyle(color: Colors.black54, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _coloredStatusRow(String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'الحالة:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16),
          ),
          Text(
            _getStatusText(status),
            style: TextStyle(
              color: _getStatusColor(status),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  static String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'قيد الانتظار';
      case 'processing':
        return 'يعالج';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      case 'refunded':
        return 'تم استرداد المبلغ';
      default:
        return 'غير معروف';
    }
  }

  static Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.deepOrange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'refunded':
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _buildCancelOrderButton(BuildContext context, order) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<CancelOrderCubit>().cancelOrder(order.id);
        context.read<OrdersCubit>().fetchOrders();
      },
      icon: const Icon(Icons.cancel, color: Colors.white),
      label: const Text('إلغاء الطلب', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[300],
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
