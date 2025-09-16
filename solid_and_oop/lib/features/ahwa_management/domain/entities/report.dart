
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';

class DailyReport {
  final DateTime date;
  final List<Order> orders;
  final Map<DrinkType, int> drinkSales;
  final double totalRevenue;
  final int totalOrders;
  final DrinkType? topSellingDrink;

  DailyReport({
    required this.date,
    required this.orders,
    required this.drinkSales,
    required this.totalRevenue,
    required this.totalOrders,
    this.topSellingDrink,
  });

  factory DailyReport.generate(List<Order> orders, DateTime date) {
    final todayOrders = orders.where((order) =>
      order.createdAt.day == date.day &&
      order.createdAt.month == date.month &&
      order.createdAt.year == date.year
    ).toList();

    final drinkSales = <DrinkType, int>{};
    double totalRevenue = 0;

    for (final order in todayOrders) {
      drinkSales[order.drinkType] = (drinkSales[order.drinkType] ?? 0) + 1;
      if (order.status == OrderStatus.completed) {
        totalRevenue += order.price;
      }
    }

    DrinkType? topDrink;
    int maxSales = 0;
    drinkSales.forEach((drink, count) {
      if (count > maxSales) {
        maxSales = count;
        topDrink = drink;
      }
    });

    return DailyReport(
      date: date,
      orders: todayOrders,
      drinkSales: drinkSales,
      totalRevenue: totalRevenue,
      totalOrders: todayOrders.length,
      topSellingDrink: topDrink,
    );
  }
}