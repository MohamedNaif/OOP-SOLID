import 'package:dartz/dartz.dart' hide Order;
import 'package:solid_and_oop/core/errors/failures.dart';
import 'package:solid_and_oop/core/usecases/usecase.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';

class GetPendingOrders extends UseCase<List<Order>, NoParams> {
  final OrderRepository repository;

  GetPendingOrders(this.repository);

  @override
  Future<Either<Failure, List<Order>>> call(NoParams params) async {
    return await repository.getPendingOrders();
  }
}
