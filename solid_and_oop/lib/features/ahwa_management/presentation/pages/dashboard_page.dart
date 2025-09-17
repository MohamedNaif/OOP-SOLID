
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_state.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/add_order_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/pages/reports_page.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/widgets/order_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Ahwa Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.assessment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<OrderCubit>(),
                    child: const ReportsPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            if (state.pendingOrders.isEmpty) {
              return const Center(
                child: Text(
                  'مفيش طلبات دلوقتي',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.pendingOrders.length,
              itemBuilder: (context, index) {
                final order = state.pendingOrders[index];
                return OrderCard(
                  order: order,
                  onComplete: () {
                    context.read<OrderCubit>().markOrderAsCompleted(order);
                  },
                );
              },
            );
          } else if (state is OrderError) {
            return Center(
              child: Text(
                'خطأ: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<OrderCubit>(),
                child: const AddOrderPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}