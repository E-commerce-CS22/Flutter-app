import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/app_bar.dart';
import '../../../../../core/configs/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the text direction to RTL
      child: Scaffold(
        appBar: CurvedAppBar(
          title: const Text('حسابي'),
          height: 120,
          fontSize: 30,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'حازم النكبة',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Orders and Favorites Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Orders page
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: AppColors.primary, width: 1.0), // Adjust border for RTL
                          ),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.shopping_bag, color: AppColors.primary),
                            SizedBox(height: 4),
                            Text('طلباتي', style: TextStyle(color: AppColors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Favorites page
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: const [
                            Icon(Icons.favorite, color: AppColors.primary),
                            SizedBox(height: 4),
                            Text('المفضلة', style: TextStyle(color: AppColors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1.5),

              // My Account Section
              buildSectionHeader('حسابي'),
              buildAccountOption(
                title: 'إعدادات الملف الشخصي',
                onTap: () {
                  // Handle Profile Settings
                },
              ),
              buildAccountOption(
                title: 'عناوين الشحن',
                subOptions: [
                  buildSubOption(
                    title: 'إضافة عنوان',
                    description: 'عنوان توصيل جديد',
                    icon: Icons.add_circle_outline,
                    onTap: () {
                      // Handle Add Address
                    },
                  ),
                  buildSubOption(
                    title: 'جانب فلافل اللذيذ',
                    description: 'جانب مشاوي النور، شارع الجامعة الجديد...',
                    icon: Icons.more_vert,
                    onTap: () {
                      // Handle Edit Address
                    },
                  ),
                ],
                onTap: () {},
              ),
              const Divider(thickness: 1.5),

              // Store Assistance Section
              buildSectionHeader('مساعد المتجر'),
              buildAccountOption(
                title: 'تواصل معنا',
                onTap: () {
                  // Handle Contact Us
                },
              ),
              buildAccountOption(
                title: 'الاستبدال والاسترجاع',
                onTap: () {
                  // Handle Returns
                },
              ),
              buildAccountOption(
                title: 'سياسة الخصوصية',
                onTap: () {
                  // Handle Privacy Policy
                },
              ),
              buildAccountOption(
                title: 'الشروط والأحكام',
                onTap: () {
                  // Handle Terms and Conditions
                },
              ),
              const Divider(thickness: 1.5),

              // Logout
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  // Handle Logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build section headers
  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper to build main account options
  Widget buildAccountOption({
    required String title,
    List<Widget>? subOptions,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        if (subOptions != null) ...subOptions,
      ],
    );
  }

  // Helper to build sub-options under main options
  Widget buildSubOption({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title),
        subtitle: Text(description),
        onTap: onTap,
      ),
    );
  }
}
