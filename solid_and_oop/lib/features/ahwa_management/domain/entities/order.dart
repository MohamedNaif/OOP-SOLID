import 'drink.dart';

class Order extends MenuItem {
  final String customerName;
  final DrinkType drinkType;
  final String? specialInstructions;
  final OrderStatus status;
  final DateTime? completedAt;

  Order({
    required super.id,
    required this.customerName,
    required this.drinkType,
    required super.price,
    required super.createdAt,
    this.specialInstructions,
    this.status = OrderStatus.pending,
    this.completedAt,
  }) : super(name: drinkType.arabicName);

  // Encapsulation - controlling state changes
  Order markAsCompleted() {
    return Order(
      id: id,
      customerName: customerName,
      drinkType: drinkType,
      price: price,
      createdAt: createdAt,
      specialInstructions: specialInstructions,
      status: OrderStatus.completed,
      completedAt: DateTime.now(),
    );
  }

  Order copyWith({
    String? customerName,
    DrinkType? drinkType,
    double? price,
    String? specialInstructions,
    OrderStatus? status,
    DateTime? completedAt,
  }) {
    return Order(
      id: id,
      customerName: customerName ?? this.customerName,
      drinkType: drinkType ?? this.drinkType,
      price: price ?? this.price,
      createdAt: createdAt,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

enum OrderStatus { pending, completed, cancelled }