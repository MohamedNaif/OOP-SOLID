

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_state.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/widgets/report_card.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate report for today
    context.read<OrderCubit>().generateDailyReport(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('التقارير')),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is ReportGenerated) {
            final report = state.report;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReportCard(
                    title: 'ملخص اليوم',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('إجمالي الطلبات: ${report.totalOrders}'),
                        Text('الإيرادات: ${report.totalRevenue.toStringAsFixed(2)} جنيه'),
                        if (report.topSellingDrink != null)
                          Text('أكتر حاجة اتطلبت: ${report.topSellingDrink!.arabicName}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReportCard(
                    title: 'تفاصيل المبيعات',
                    content: Column(
                      children: report.drinkSales.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key.arabicName),
                              Text('${entry.value} طلب'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
