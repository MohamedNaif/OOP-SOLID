enum DrinkType {
  shai('شاي'),
  turkishCoffee('قهوة تركي'),
  hibiscusTea('كركديه'),
  greenTea('شاي أخضر'),
  nescafe('نسكافيه'),
  sahlab('سحلب'),
  yansoon('ينسون');

  final String arabicName;
  const DrinkType(this.arabicName);
}


abstract class MenuItem {
  final String id;
  final String name;
  final double price;
  final DateTime createdAt;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
  });
}