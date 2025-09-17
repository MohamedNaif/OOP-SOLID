import 'package:solid_and_oop/core/errors/failures.dart';
import 'package:solid_and_oop/core/results/result.dart';
import 'package:solid_and_oop/features/ahwa_management/data/datasources/order_local_datasource.dart';
import 'package:solid_and_oop/features/ahwa_management/data/models/order_model.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/report.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<Order>>> getAllOrders() async {
    try {
      final orders = await localDataSource.getAllOrders();
      return Success(orders);
    } catch (e) {
      return FailureResult(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Order>>> getPendingOrders() async {
    try {
      final orders = await localDataSource.getPendingOrders();
      return Success(orders);
    } catch (e) {
      return FailureResult(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Result<Order>> addOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final result = await localDataSource.addOrder(orderModel);
      return Success(result);
    } catch (e) {
      return FailureResult(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Result<Order>> updateOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final result = await localDataSource.updateOrder(orderModel);
      return Success(result);
    } catch (e) {
      return FailureResult(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Result<DailyReport>> generateDailyReport(DateTime date) async {
    try {
      final orders = await localDataSource.getAllOrders();
      final report = DailyReport.generate(orders, date);
      return Success(report);
    } catch (e) {
      return FailureResult(LocalDataFailure(e.toString()));
    }
  }
}
