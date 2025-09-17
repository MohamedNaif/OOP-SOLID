import 'package:flutter/material.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/add_order_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/dashboard_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/reports_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardPage();
      case 1:
        return const ReportsPage();
      default:
        return const DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      // appBar: AppBar(
      //   title: const Text('Smart Ahwa Manager'),
      //   centerTitle: true,
      // ),
      body: SafeArea(child: _getCurrentPage()),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
