import 'package:dartz/dartz.dart' hide Order;
import 'package:solid_and_oop/core/errors/failures.dart';
import 'package:solid_and_oop/core/usecases/usecase.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';

class AddOrder extends UseCase<Order, AddOrderParams> {
  final OrderRepository repository;

  AddOrder(this.repository);

  @override
  Future<Either<Failure, Order>> call(AddOrderParams params) async {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: params.customerName,
      drinkType: params.drinkType,
      price: _getDrinkPrice(params.drinkType),
      createdAt: DateTime.now(),
      specialInstructions: params.specialInstructions,
    );
    return await repository.addOrder(order);
  }

  double _getDrinkPrice(DrinkType type) {
    // Polymorphism through method behavior based on type
    switch (type) {
      case DrinkType.shai:
        return 10.0;
      case DrinkType.turkishCoffee:
        return 15.0;
      case DrinkType.hibiscusTea:
        return 12.0;
      case DrinkType.greenTea:
        return 12.0;
      case DrinkType.nescafe:
        return 20.0;
      case DrinkType.sahlab:
        return 25.0;
      case DrinkType.yansoon:
        return 10.0;
    }
  }
}

class AddOrderParams {
  final String customerName;
  final DrinkType drinkType;
  final String? specialInstructions;

  AddOrderParams({
    required this.customerName,
    required this.drinkType,
    this.specialInstructions,
  });
}