import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.customerName,
    required super.drinkType,
    required super.price,
    required super.createdAt,
    super.specialInstructions,
    super.status,
    super.completedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      customerName: json['customerName'],
      drinkType: DrinkType.values.firstWhere(
        (e) => e.toString() == json['drinkType'],
      ),
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      specialInstructions: json['specialInstructions'],
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      completedAt: json['completedAt'] != null 
        ? DateTime.parse(json['completedAt']) 
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'drinkType': drinkType.toString(),
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'specialInstructions': specialInstructions,
      'status': status.toString(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      customerName: order.customerName,
      drinkType: order.drinkType,
      price: order.price,
      createdAt: order.createdAt,
      specialInstructions: order.specialInstructions,
      status: order.status,
      completedAt: order.completedAt,
    );
  }
}