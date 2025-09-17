import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/bloc_observer.dart';
import 'package:solid_and_oop/config/theme/lang_manager.dart';
import 'package:solid_and_oop/core/di/di.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/config/routing/app_router.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
   await EasyLocalization.ensureInitialized();
  
  Bloc.observer = MyBlocObserver();
  MyBlocObserver();
   runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocal, englishLocal],
      fallbackLocale: englishLocal,
      path: assetsLocalization,

      child: const SmartAhwaApp(),
    ),
  );
  
}

class SmartAhwaApp extends StatefulWidget {
  const SmartAhwaApp({super.key});

  @override
  State<SmartAhwaApp> createState() => _SmartAhwaAppState();
}

class _SmartAhwaAppState extends State<SmartAhwaApp> {

   @override
  void didChangeDependencies() {
    context.setLocale(arabicLocal);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ahwa Manager',
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'Cairo'),
      onGenerateRoute: AppRouter.onGenerateRoute,
       localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: AppRouter.home,
      builder: (context, child) => BlocProvider(
        create: (_) => sl<OrderCubit>(),
        child: child!,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
