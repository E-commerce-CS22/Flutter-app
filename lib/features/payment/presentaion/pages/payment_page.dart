import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import '../../../authentication/presentation/blocs/user_display_cubit.dart';
import '../../../authentication/presentation/blocs/user_display_state.dart';
import '../../../cart/domain/entities/cart_entity.dart';
import '../../../orders/domain/entities/Create_Order_Params.dart';
import '../../../orders/domain/entities/Order_item_params.dart';
import '../../../orders/presentation/blocs/create_order_bloc/create_order_cubit.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  final List<CartItemEntity> items;

  const PaymentPage({
    super.key,
    required this.total,
    required this.items,

  });

  @override
  _PaymentPageState createState() => _PaymentPageState();


}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  String _selectedPaymentMethod = 'cash_on_delivery';

  @override
  Widget build(BuildContext context) {
    for (var item in widget.items) {
      print('ID: ${item.id}, Name: ${item.name}, Quantity: ${item.quantity}');
    }
    List<OrderItemParam> _getFormattedItems(List<CartItemEntity> items) {
      return items.map((item) {
        return OrderItemParam(
          productId: item.id,
          productVariantId: item.id,
          quantity: item.quantity,
        );
      }).toList();
    }
    final formattedItems = _getFormattedItems(widget.items);
    print("gggggggggggggggg");



    print(_getFormattedItems);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('الدفع'),
          fontSize: 30,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShippingAddressField(controller: _addressController),
              const SizedBox(height: 16),
              NotesField(controller: _notesController),
              const SizedBox(height: 24),
              AmountSummary(total: widget.total,),
              const SizedBox(height: 24),
              PaymentMethodsSection(
                selectedMethod: _selectedPaymentMethod,
                onSelect: (method) {
                  setState(() {
                    _selectedPaymentMethod = method;
                  });
                },
              ),
              if (_selectedPaymentMethod == 'jawali_wallet') ...[
                const SizedBox(height: 16),
                JawaliFields(
                  phoneController: _phoneController,
                  codeController: _codeController,
                ),
              ],
              const SizedBox(height: 24),
              ConfirmButton(
                onPressed: () {
                  final orderParams = CreateOrderParams(
                    items: _getFormattedItems(widget.items),
                    shippingAddress: _addressController.text,
                    paymentMethod: _selectedPaymentMethod,
                    shippingMethod: 'standard', // حدد حسب المطلوب
                    notes: _notesController.text,
                  );

                  context.read<CreateOrderCubit>().createOrder(orderParams);



                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShippingAddressField extends StatelessWidget {
  final TextEditingController controller;

  const ShippingAddressField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('عنوان الشحن',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BlocBuilder<UserDisplayCubit, UserDisplayState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              controller.text = state.userEntity.address;
            }
            return TextField(
              controller: controller,
              maxLines: 2,
              decoration: const InputDecoration(
                  hintText: 'ادخل عنوان الشحن',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            );
          },
        ),
      ],
    );
  }
}

class NotesField extends StatelessWidget {
  final TextEditingController controller;

  const NotesField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ملاحظات',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'اكتب أي ملاحظات إضافية'),
        ),
      ],
    );
  }
}

class AmountSummary extends StatelessWidget {
  final double total;

  const AmountSummary({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'المبلغ:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(
          '${total.toStringAsFixed(2)} ريال',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.grey[100]!.withOpacity(0.6) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(text),
        ),
      ),
    );
  }
}

class PaymentMethodsSection extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onSelect;

  const PaymentMethodsSection({
    super.key,
    required this.selectedMethod,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر طريقة الدفع',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        PaymentMethodCard(
          icon: Icons.money,
          text: 'الدفع عند الاستلام',
          isSelected: selectedMethod == 'cash_on_delivery',
          onTap: () => onSelect('cash_on_delivery'),
        ),
        const SizedBox(height: 8),
        PaymentMethodCard(
          icon: Icons.account_balance_wallet,
          text: 'الدفع بواسطة محفظة جوالي',
          isSelected: selectedMethod == 'jawali_wallet',
          onTap: () => onSelect('jawali_wallet'),
        ),
      ],
    );
  }
}

class JawaliFields extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController codeController;

  const JawaliFields({
    super.key,
    required this.phoneController,
    required this.codeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('رقم الجوال',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: 'أدخل رقم الجوال'),
        ),
        const SizedBox(height: 12),
        const Text('كود الشراء',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: codeController,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'أدخل كود الشراء'),
        ),
      ],
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ConfirmButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 55),
        ),
        child: const Text(
          'تأكيد الطلب',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
