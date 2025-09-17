import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/add_order_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/dashboard_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/reports_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const DashboardPage(),
      // const AddOrderPage(),
      const ReportsPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages
            .map(
              (page) => BlocProvider.value(
                value: context.read<OrderCubit>(),
                child: page,
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'الطلبات'),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_circle_outline),
          //   label: 'إضافة',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'التقارير',
          ),
        ],
      ),
    );
  }
}
