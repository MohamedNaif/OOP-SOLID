import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/core/usecases/usecase.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/add_order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/complete_order.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/generate_reports.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/usecases/get_pending_orders.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final AddOrder addOrderUseCase;
  final CompleteOrder completeOrderUseCase;
  final GetPendingOrders getPendingOrdersUseCase;
  final GenerateReports generateReportsUseCase;
  
  List<Order> allOrders = [];
  List<Order> pendingOrders = [];
  
  OrderCubit({
    required this.addOrderUseCase,
    required this.completeOrderUseCase,
    required this.getPendingOrdersUseCase,
    required this.generateReportsUseCase,
  }) : super(OrderInitial());
  
  Future<void> loadPendingOrders() async {
    emit(OrderLoading());
    
    final result = await getPendingOrdersUseCase(NoParams());
    
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) {
        pendingOrders = orders;
        emit(OrdersLoaded(orders: allOrders, pendingOrders: orders));
      },
    );
  }
  
  Future<void> addNewOrder({
    required String customerName,
    required DrinkType drinkType,
    String? specialInstructions,
  }) async {
    emit(OrderLoading());
    
    final params = AddOrderParams(
      customerName: customerName,
      drinkType: drinkType,
      specialInstructions: specialInstructions,
    );
    
    final result = await addOrderUseCase(params);
    
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) {
        allOrders.add(order);
        pendingOrders.add(order);
        emit(OrderAdded(order));
        loadPendingOrders();
      },
    );
  }
  
  Future<void> markOrderAsCompleted(Order order) async {
    emit(OrderLoading());
    
    final params = CompleteOrderParams(order: order);
    final result = await completeOrderUseCase(params);
    
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (completedOrder) {
        pendingOrders.removeWhere((o) => o.id == completedOrder.id);
        final index = allOrders.indexWhere((o) => o.id == completedOrder.id);
        if (index != -1) {
          allOrders[index] = completedOrder;
        }
        emit(OrderCompleted(completedOrder));
        loadPendingOrders();
      },
    );
  }
  
  Future<void> generateDailyReport(DateTime date) async {
    emit(OrderLoading());
    
    final params = GenerateReportsParams(date: date);
    final result = await generateReportsUseCase(params);
    
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (report) => emit(ReportGenerated(report)),
    );
  }
}
