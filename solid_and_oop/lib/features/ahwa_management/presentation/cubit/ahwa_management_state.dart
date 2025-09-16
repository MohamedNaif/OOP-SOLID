import 'package:equatable/equatable.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/report.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  final List<Order> pendingOrders;
  
  const OrdersLoaded({
    required this.orders,
    required this.pendingOrders,
  });
  
  @override
  List<Object> get props => [orders, pendingOrders];
}

class OrderAdded extends OrderState {
  final Order order;
  
  const OrderAdded(this.order);
  
  @override
  List<Object> get props => [order];
}

class OrderCompleted extends OrderState {
  final Order order;
  
  const OrderCompleted(this.order);
  
  @override
  List<Object> get props => [order];
}

class ReportGenerated extends OrderState {
  final DailyReport report;
  
  const ReportGenerated(this.report);
  
  @override
  List<Object> get props => [report];
}

class OrderError extends OrderState {
  final String message;
  
  const OrderError(this.message);
  
  @override
  List<Object> get props => [message];
}
