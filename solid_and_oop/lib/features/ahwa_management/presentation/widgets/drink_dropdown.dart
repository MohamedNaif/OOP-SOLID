
import 'package:flutter/material.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';

class DrinkDropdown extends StatelessWidget {
  final DrinkType selectedDrink;
  final ValueChanged<DrinkType?> onChanged;

  const DrinkDropdown({
    super.key,
    required this.selectedDrink,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DrinkType>(
      value: selectedDrink,
      decoration: const InputDecoration(
        labelText: 'نوع المشروب',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.local_cafe),
      ),
      items: DrinkType.values.map((drink) {
        return DropdownMenuItem(
          value: drink,
          child: Text(drink.arabicName),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
