import 'package:dartz/dartz.dart' hide Order;
import 'package:solid_and_oop/core/errors/failures.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/report.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Order>>> getAllOrders();
  Future<Either<Failure, List<Order>>> getPendingOrders();
  Future<Either<Failure, Order>> addOrder(Order order);
  Future<Either<Failure, Order>> updateOrder(Order order);
  Future<Either<Failure, DailyReport>> generateDailyReport(DateTime date);
}