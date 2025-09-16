// class LocalNotificationService {
//   void send(String message) {
//     print('Sending local notification: $message');
//   }
// }

// class AppNotifier {
//   final LocalNotificationService service = LocalNotificationService();
//   void notifyUser(String message) {
//     service.send(message);
//   }
// }



//? solution 
abstract class Notifier {
  void send(String message);
}

/// Concrete implementation: Local notifications
class LocalNotificationService implements Notifier {
  @override
  void send(String message) {
    print('Sending local notification: $message');
  }
}

/// Another implementation: Push notifications
class PushNotificationService implements Notifier {
  @override
  void send(String message) {
    print('Sending push notification: $message');
  }
}

/// High-level AppNotifier depends on abstraction
class AppNotifier {
  final Notifier service;

  AppNotifier(this.service);

  void notifyUser(String message) {
    service.send(message);
  }
}