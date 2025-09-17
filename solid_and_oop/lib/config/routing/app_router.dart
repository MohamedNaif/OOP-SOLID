import 'package:flutter/material.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/home_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/add_order_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/reports_page.dart';

class AppRouter {
  static const String home = '/';
  static const String addOrder = '/add-order';
  static const String reports = '/reports';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case addOrder:
        return MaterialPageRoute(builder: (_) => const AddOrderPage());
      case reports:
        return MaterialPageRoute(builder: (_) => const ReportsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page not found: ${settings.name}')),
          ),
        );
    }
  }
}
