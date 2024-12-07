import 'package:flutter/foundation.dart';
import 'package:loo/src/global_state_exceptions.dart';

class Loo {
  Loo._internal();
  static final Loo _instance = Loo._internal();
  static Loo get instance => _instance;

  final Map<Type, ChangeNotifier> _states = {};
  VoidCallback? _forceUpdateCallback;

  void setForceUpdateCallback(VoidCallback callback) {
    _forceUpdateCallback = callback;
  }

  void register<T extends ChangeNotifier>(T state) {
    _states[T] = state;
    state.addListener(() {
      _forceUpdateCallback?.call();
    });
  }

  T get<T extends ChangeNotifier>() {
    final state = _states[T];
    if (state == null) {
      throw GlobalStateNotFoundException(T);
    }
    return state as T;
  }
}
