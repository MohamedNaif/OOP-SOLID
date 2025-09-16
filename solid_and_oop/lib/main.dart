import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/core/di/di.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const SmartAhwaApp());
}

class SmartAhwaApp extends StatelessWidget {
  const SmartAhwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ahwa Manager',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Cairo',
      ),
      home: BlocProvider(
        create: (_) => sl<OrderCubit>()..loadPendingOrders(),
        child: const DashboardPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// lib/features/ahwa_management/presentation/pages/dashboard_page.dart
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Ahwa Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<OrderCubit>(),
                    child: const ReportsPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            if (state.pendingOrders.isEmpty) {
              return const Center(
                child: Text(
                  'مفيش طلبات دلوقتي',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.pendingOrders.length,
              itemBuilder: (context, index) {
                final order = state.pendingOrders[index];
                return OrderCard(
                  order: order,
                  onComplete: () {
                    context.read<OrderCubit>().markOrderAsCompleted(order);
                  },
                );
              },
            );
          } else if (state is OrderError) {
            return Center(
              child: Text(
                'خطأ: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<OrderCubit>(),
                child: const AddOrderPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// lib/features/ahwa_management/presentation/pages/add_order_page.dart
class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _specialInstructionsController = TextEditingController();
  DrinkType _selectedDrink = DrinkType.shai;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلب جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الزبون',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك اكتب اسم الزبون';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DrinkDropdown(
                selectedDrink: _selectedDrink,
                onChanged: (drink) {
                  setState(() {
                    _selectedDrink = drink!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialInstructionsController,
                decoration: const InputDecoration(
                  labelText: 'طلبات خاصة (اختياري)',
                  hintText: 'مثلاً: نعناع زيادة يا ريس',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<OrderCubit>().addNewOrder(
                      customerName: _customerNameController.text,
                      drinkType: _selectedDrink,
                      specialInstructions: _specialInstructionsController.text.isEmpty 
                        ? null 
                        : _specialInstructionsController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('إضافة الطلب', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }
}

// lib/features/ahwa_management/presentation/pages/reports_page.dart
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate report for today
    context.read<OrderCubit>().generateDailyReport(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('التقارير')),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is ReportGenerated) {
            final report = state.report;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReportCard(
                    title: 'ملخص اليوم',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('إجمالي الطلبات: ${report.totalOrders}'),
                        Text('الإيرادات: ${report.totalRevenue.toStringAsFixed(2)} جنيه'),
                        if (report.topSellingDrink != null)
                          Text('أكتر حاجة اتطلبت: ${report.topSellingDrink!.arabicName}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReportCard(
                    title: 'تفاصيل المبيعات',
                    content: Column(
                      children: report.drinkSales.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key.arabicName),
                              Text('${entry.value} طلب'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// =====================================================
// PRESENTATION LAYER - Widgets
// =====================================================

// lib/features/ahwa_management/presentation/widgets/order_card.dart
class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onComplete;

  const OrderCard({
    super.key,
    required this.order,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    order.drinkType.arabicName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.brown,
                ),
              ],
            ),
            if (order.specialInstructions != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.specialInstructions!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.price.toStringAsFixed(2)} جنيه',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                TextButton.icon(
                  onPressed: onComplete,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('تم التحضير'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// lib/features/ahwa_management/presentation/widgets/drink_dropdown.dart
class DrinkDropdown extends StatelessWidget {
  final DrinkType selectedDrink;
  final ValueChanged<DrinkType?> onChanged;

  const DrinkDropdown({
    super.key,
    required this.selectedDrink,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DrinkType>(
      value: selectedDrink,
      decoration: const InputDecoration(
        labelText: 'نوع المشروب',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.local_cafe),
      ),
      items: DrinkType.values.map((drink) {
        return DropdownMenuItem(
          value: drink,
          child: Text(drink.arabicName),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

// lib/features/ahwa_management/presentation/widgets/report_card.dart
class ReportCard extends StatelessWidget {
  final String title;
  final Widget content;

  const ReportCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const Divider(height: 20),
            content,
          ],
        ),
      ),
    );
  }
}

// =====================================================
// THEME CONFIGURATION
// =====================================================

// lib/config/theme/app_colors.dart
class AppColors {
  static const primary = Color(0xFF6F4E37);
  static const secondary = Color(0xFFD2691E);
  static const background = Color(0xFFF5F5DC);
  static const error = Color(0xFFD32F2F);
  static const success = Color(0xFF388E3C);
  static const pending = Color(0xFFFFA726);
  static const completed = Color(0xFF66BB6A);
}

// lib/config/theme/text_styles.dart
class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}