
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/drink.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/cubit/ahwa_management_cubit.dart';
import 'package:solid_and_oop/features/ahwa_management/presentation/widgets/drink_dropdown.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _specialInstructionsController = TextEditingController();
  DrinkType _selectedDrink = DrinkType.shai;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلب جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الزبون',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك اكتب اسم الزبون';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DrinkDropdown(
                selectedDrink: _selectedDrink,
                onChanged: (drink) {
                  setState(() {
                    _selectedDrink = drink!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialInstructionsController,
                decoration: const InputDecoration(
                  labelText: 'طلبات خاصة (اختياري)',
                  hintText: 'مثلاً: نعناع زيادة يا ريس',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<OrderCubit>().addNewOrder(
                      customerName: _customerNameController.text,
                      drinkType: _selectedDrink,
                      specialInstructions: _specialInstructionsController.text.isEmpty 
                        ? null 
                        : _specialInstructionsController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('إضافة الطلب', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }
}