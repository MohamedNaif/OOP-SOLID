// abstract class WidgetController {
//   void initState();
//   void dispose();
//   void handleAnimation();
//   void handleNetwork();
// }

// class SimpleButtonController implements WidgetController {
//   @override
//   void initState() => print('Init button');
//   @override
//   void dispose() => print('Dispose button');
//   @override
//   void handleAnimation() =>
//       throw UnimplementedError('No animationin simple button');
//   @override
//   void handleNetwork() => throw UnimplementedError('No network in button ');
// }


/// Core controller for all widgets
abstract class BaseController {
  void initState();
  void dispose();
}

/// Optional controller for animation
abstract class AnimationControllerMixin {
  void handleAnimation();
}

/// Optional controller for networking
abstract class NetworkControllerMixin {
  void handleNetwork();
}

/// Simple button controller → only cares about init/dispose
class SimpleButtonController implements BaseController {
  @override
  void initState() => print('Init button');

  @override
  void dispose() => print('Dispose button');
}

/// Fancy widget controller → supports animation
class FancyWidgetController implements BaseController, AnimationControllerMixin {
  @override
  void initState() => print('Init fancy widget');

  @override
  void dispose() => print('Dispose fancy widget');

  @override
  void handleAnimation() => print('Handle animation in fancy widget');
}

/// Networked widget controller → supports network
class NetworkedWidgetController
    implements BaseController, NetworkControllerMixin {
  @override
  void initState() => print('Init network widget');

  @override
  void dispose() => print('Dispose network widget');

  @override
  void handleNetwork() => print('Handle network request');
}