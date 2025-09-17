// abstract class WidgetController {
//   void initState();
//   void dispose();
//   void handleAnimation();
//   void handleNetwork();
// }

// class SimpleButtonController implements WidgetController {
//   @override
//   void initState() => log('Init button');
//   @override
//   void dispose() => log('Dispose button');
//   @override
//   void handleAnimation() =>
//       throw UnimplementedError('No animationin simple button');
//   @override
//   void handleNetwork() => throw UnimplementedError('No network in button ');
// }


import 'dart:developer';

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
  void initState() => log('Init button');

  @override
  void dispose() => log('Dispose button');
}

/// Fancy widget controller → supports animation
class FancyWidgetController implements BaseController, AnimationControllerMixin {
  @override
  void initState() => log('Init fancy widget');

  @override
  void dispose() => log('Dispose fancy widget');

  @override
  void handleAnimation() => log('Handle animation in fancy widget');
}

/// Networked widget controller → supports network
class NetworkedWidgetController
    implements BaseController, NetworkControllerMixin {
  @override
  void initState() => log('Init network widget');

  @override
  void dispose() => log('Dispose network widget');

  @override
  void handleNetwork() => log('Handle network request');
}