
import 'package:flutter/material.dart';

class SalesItem extends StatelessWidget {
  final String drinkName;
  final int quantity;
  final int totalQuantity;

  const SalesItem({super.key, 
    required this.drinkName,
    required this.quantity,
    required this.totalQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalQuantity > 0 ? (quantity / totalQuantity) : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  drinkName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.brown.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$quantity طلب',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.brown.shade600),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(percentage * 100).toStringAsFixed(1)}% من إجمالي المبيعات',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
