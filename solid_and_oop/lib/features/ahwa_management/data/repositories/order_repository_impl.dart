import 'package:dartz/dartz.dart' hide Order;
import 'package:solid_and_oop/core/errors/failures.dart';
import 'package:solid_and_oop/features/ahwa_management/data/datasources/order_local_datasource.dart';
import 'package:solid_and_oop/features/ahwa_management/data/models/order_model.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/report.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Order>>> getAllOrders() async {
    try {
      final orders = await localDataSource.getAllOrders();
      return Right(orders);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getPendingOrders() async {
    try {
      final orders = await localDataSource.getPendingOrders();
      return Right(orders);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> addOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final result = await localDataSource.addOrder(orderModel);
      return Right(result);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> updateOrder(Order order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final result = await localDataSource.updateOrder(orderModel);
      return Right(result);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyReport>> generateDailyReport(DateTime date) async {
    try {
      final orders = await localDataSource.getAllOrders();
      final report = DailyReport.generate(orders, date);
      return Right(report);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }
}
