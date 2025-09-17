import 'package:solid_and_oop/core/results/result.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/report.dart';

abstract class OrderRepository {
  Future<Result<List<Order>>> getAllOrders();
  Future<Result<List<Order>>> getPendingOrders();
  Future<Result<Order>> addOrder(Order order);
  Future<Result<Order>> updateOrder(Order order);
  Future<Result<DailyReport>> generateDailyReport(DateTime date);
}
