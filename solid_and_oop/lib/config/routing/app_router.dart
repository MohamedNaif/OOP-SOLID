// import 'package:flutter/material.dart';
// import '../../features/ahwa_management/presentation/pages/dashboard_page.dart';
// import '../../features/ahwa_management/presentation/pages/add_order_page.dart';
// import '../../features/ahwa_management/presentation/pages/reports_page.dart';

// class AppRouter {
//   static const String dashboard = '/';
//   static const String addOrder = '/add-order';
//   static const String reports = '/reports';

//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case dashboard:
//         return MaterialPageRoute(builder: (_) => DashboardPage());
//       case addOrder:
//         return MaterialPageRoute(builder: (_) => AddOrderPage());
//       case reports:
//         return MaterialPageRoute(builder: (_) => ReportsPage());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('Page not found: ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }
