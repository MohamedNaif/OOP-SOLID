// class UserModel {
//   String name = '';
//   int age = 0;
//   String email = '';
//   void updateUser(String name, int age, String email) {
//     this.name = name;
//     this.age = age;
//     this.email = email;
//   }

//   void saveToFirestore() {
//     print('Saving $name, $age, $email to Firestore');
//   }
// }


import 'package:flutter/foundation.dart';

abstract class FirestoreServiceRepository {
  updateUser(String name, int age, String email);
  saveToFirestore();
}

class FirestoreServiceRepositoryImpl extends FirestoreServiceRepository {
  final UserModel userModel;

  FirestoreServiceRepositoryImpl({required this.userModel});

  @override
  updateUser(String name, int age, String email) {
    userModel.name = name;
    userModel.age = age;
    userModel.email = email;

    if (kDebugMode) {
      print(
      'Updating ${userModel.name}, ${userModel.age}, ${userModel.email} to Firestore',
    );
    }
  }

  @override
  saveToFirestore() {
    if (kDebugMode) {
      print(
      'Saving ${userModel.name}, ${userModel.age}, ${userModel.email} to Firestore',
    );
    }
  }
}

// ? solution
class UserModel {
  String _name;
  int _age;
  String _email;

  UserModel({required String name, required int age, required String email})
    : _name = name,
      _age = age,
      _email = email;

  // Getters
  String get name => _name;
  int get age => _age;
  String get email => _email;

  // Setters with validation
  set name(String value) {
    if (value.isEmpty) throw ArgumentError('Name cannot be empty');
    _name = value;
  }

  set age(int value) {
    if (value < 0) throw ArgumentError('Age cannot be negative');
    _age = value;
  }

  set email(String value) {
    if (!value.contains('@')) throw ArgumentError('Invalid email');
    _email = value;
  }

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {'name': _name, 'age': _age, 'email': _email};
  }

  // Create model from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      email: map['email'] ?? '',
    );
  }
}

void main() {
  final userModel = UserModel(
    name: 'Naif',
    age: 24,
    email: 'naif@example.com',
  );
  final firestoreServiceRepository = FirestoreServiceRepositoryImpl(
    userModel: userModel,
  );
  firestoreServiceRepository.updateUser(
    userModel.name,
    userModel.age,
    userModel.email,
  );
  firestoreServiceRepository.saveToFirestore();
}
