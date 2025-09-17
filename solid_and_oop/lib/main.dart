import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/core/di/di.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/dashboard_page.dart';

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

