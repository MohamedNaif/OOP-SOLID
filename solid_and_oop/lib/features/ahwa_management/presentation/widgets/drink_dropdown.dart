import 'package:flutter/material.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';

class DrinkDropdown extends StatefulWidget {
  final DrinkType selectedDrink;
  final ValueChanged<DrinkType?> onChanged;

  const DrinkDropdown({
    super.key,
    required this.selectedDrink,
    required this.onChanged,
  });

  @override
  State<DrinkDropdown> createState() => _DrinkDropdownState();
}

class _DrinkDropdownState extends State<DrinkDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  IconData _getDrinkIcon(DrinkType drinkType) {
    switch (drinkType) {
      case DrinkType.shai:
        return Icons.emoji_food_beverage;
      case DrinkType.hibiscusTea:
        return Icons.local_cafe;
      case DrinkType.greenTea:
        return Icons.local_cafe;
      case DrinkType.turkishCoffee:
        return Icons.coffee;
      case DrinkType.nescafe:
        return Icons.local_cafe;
      case DrinkType.sahlab:
        return Icons.icecream;
      case DrinkType.yansoon:
        return Icons.local_drink;
    }
  }

  Color _getDrinkColor(DrinkType drinkType) {
    switch (drinkType) {
      case DrinkType.shai:
        return Colors.orange.shade600;
      case DrinkType.hibiscusTea:
        return Colors.brown.shade700;
      case DrinkType.greenTea:
        return Colors.brown.shade700;
      case DrinkType.turkishCoffee:
        return Colors.brown.shade700;
      case DrinkType.nescafe:
        return Colors.brown.shade500;
      case DrinkType.sahlab:
        return Colors.purple.shade400;
      case DrinkType.yansoon:
        return Colors.green.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isExpanded ? Colors.brown.shade600 : Colors.grey.shade300,
            width: _isExpanded ? 2 : 1,
          ),
          color: Colors.grey.shade50,
        ),
        child: DropdownButtonFormField<DrinkType>(
          value: widget.selectedDrink,
          isExpanded: true,
          isDense: false,
          itemHeight: null,
          decoration: InputDecoration(
            labelText: 'نوع المشروب',
            prefixIcon: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getDrinkColor(
                  widget.selectedDrink,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getDrinkIcon(widget.selectedDrink),
                color: _getDrinkColor(widget.selectedDrink),
                size: 20,
              ),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            labelStyle: TextStyle(
              color: Colors.brown.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 8,
          items: DrinkType.values.map((drink) {
            return DropdownMenuItem(
              value: drink,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: _getDrinkColor(drink).withValues(alpha: 0.1),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Icon(
                    //     _getDrinkIcon(drink),
                    //     color: _getDrinkColor(drink),
                    //     size: 18,
                    //   ),
                    // ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            drink.arabicName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _getDrinkDescription(drink),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // if (drink == widget.selectedDrink)
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     decoration: BoxDecoration(
                    //       color: Colors.brown.shade600,
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: const Icon(
                    //       Icons.check,
                    //       color: Colors.white,
                    //       size: 16,
                    //     ),
                    //   ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (drink) {
            _onTap();
            widget.onChanged(drink);
          },
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
          },
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.brown.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.brown.shade700,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  String _getDrinkDescription(DrinkType drinkType) {
    switch (drinkType) {
      case DrinkType.shai:
        return 'شاي أحمر تقليدي';
      case DrinkType.hibiscusTea:
        return 'كركديه';
      case DrinkType.greenTea:
        return 'شاي أخضر';
      case DrinkType.turkishCoffee:
        return 'قهوة تركية أصيلة';
      case DrinkType.nescafe:
        return 'قهوة سريعة التحضير';
      case DrinkType.sahlab:
        return 'مشروب دافئ بالحليب';
      case DrinkType.yansoon:
        return 'مشروب عشبي دافئ';
      default:
        return '';
    }
  }
}
