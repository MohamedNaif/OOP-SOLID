import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:solid_and_oop/features/ahwa_management/data/models/order_model.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getAllOrders();
  Future<List<OrderModel>> getPendingOrders();
  Future<OrderModel> addOrder(OrderModel order);
  Future<OrderModel> updateOrder(OrderModel order);
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const ordersKey = 'ORDERS_LIST';

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final jsonString = sharedPreferences.getString(ordersKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => OrderModel.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<List<OrderModel>> getPendingOrders() async {
    final allOrders = await getAllOrders();
    return allOrders.where((order) => order.status == OrderStatus.pending).toList();
  }

  @override
  Future<OrderModel> addOrder(OrderModel order) async {
    final orders = await getAllOrders();
    orders.add(order);
    await _saveOrders(orders);
    return order;
  }

  @override
  Future<OrderModel> updateOrder(OrderModel order) async {
    final orders = await getAllOrders();
    final index = orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      orders[index] = order;
      await _saveOrders(orders);
    }
    return order;
  }

  Future<void> _saveOrders(List<OrderModel> orders) async {
    final jsonList = orders.map((order) => order.toJson()).toList();
    await sharedPreferences.setString(ordersKey, json.encode(jsonList));
  }
}