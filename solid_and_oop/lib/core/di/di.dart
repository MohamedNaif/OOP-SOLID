import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_and_oop/features/ahwa_management/data/datasources/order_local_datasource.dart';
import 'package:solid_and_oop/features/ahwa_management/data/repositories/order_repository_impl.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/add_order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/complete_order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/generate_reports.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/get_pending_orders.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // Data sources
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
  );
  
  // Repositories
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(localDataSource: sl()),
  );
  
  // Use cases
  sl.registerLazySingleton(() => AddOrder(sl()));
  sl.registerLazySingleton(() => CompleteOrder(sl()));
  sl.registerLazySingleton(() => GetPendingOrders(sl()));
  sl.registerLazySingleton(() => GenerateReports(sl()));
  
  // Cubit
  sl.registerFactory(
    () => OrderCubit(
      addOrderUseCase: sl(),
      completeOrderUseCase: sl(),
      getPendingOrdersUseCase: sl(),
      generateReportsUseCase: sl(),
    ),
  );
}
