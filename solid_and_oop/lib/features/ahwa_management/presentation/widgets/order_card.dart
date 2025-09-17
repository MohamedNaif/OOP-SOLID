
import 'package:flutter/material.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onComplete;

  const OrderCard({
    super.key,
    required this.order,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    order.drinkType.arabicName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.brown,
                ),
              ],
            ),
            if (order.specialInstructions != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.specialInstructions!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.price.toStringAsFixed(2)} جنيه',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                TextButton.icon(
                  onPressed: onComplete,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('تم التحضير'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
