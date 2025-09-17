import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// class Screen {
//   void navigate() {
//     print('Navigating to screen');
//   }
// }

// class HomeScreen extends Screen {
//   @override
//   void navigate() {
//     print('Navigating to home');
//   }
// }

// class SettingsScreen extends Screen {
//   @override
//   void navigate() {
//     throw Exception('Settings don\'t navigate this way!');
//   }
// }

// class NavigationButton extends StatelessWidget {
//   final Screen screen;
//   const NavigationButton({super.key, required this.screen});
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => screen.navigate(),
//       child: Text('Navigate'),
//     );
//   }
// }


abstract class Navigable {
  void navigate(BuildContext context);
}

abstract class Screen {}

class HomeScreen extends Screen implements Navigable {
  @override
  void navigate(BuildContext context) {
    if (kDebugMode) {
      print('Navigating to Home');
    }
    // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
  }
}

class SettingsScreen extends Screen {
  // No navigation behavior here or impl another way to navigate
}

class NavigationButton extends StatelessWidget {
  final Navigable screen;

  const NavigationButton(this.screen, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => screen.navigate(context),
      child: const Text('Navigate'),
    );
  }
}