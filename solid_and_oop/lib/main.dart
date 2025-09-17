import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/bloc_observer.dart';
import 'package:solid_and_oop/core/di/di.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/config/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  
  Bloc.observer = MyBlocObserver();
  MyBlocObserver();
  runApp(const SmartAhwaApp());
}

class SmartAhwaApp extends StatelessWidget {
  const SmartAhwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ahwa Manager',
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'Cairo'),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.home,
      builder: (context, child) => BlocProvider(
        create: (_) => sl<OrderCubit>(),
        child: child!,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
