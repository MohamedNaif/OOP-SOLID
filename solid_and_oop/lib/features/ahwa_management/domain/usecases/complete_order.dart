import 'package:solid_and_oop/core/results/result.dart';
import 'package:solid_and_oop/core/usecases/usecase.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';

class CompleteOrder extends UseCase<Order, CompleteOrderParams> {
  final OrderRepository repository;

  CompleteOrder(this.repository);

  @override
  Future<Result<Order>> call(CompleteOrderParams params) async {
    final completedOrder = params.order.markAsCompleted();
    return await repository.updateOrder(completedOrder);
  }
}

class CompleteOrderParams {
  final Order order;
  CompleteOrderParams({required this.order});
}
