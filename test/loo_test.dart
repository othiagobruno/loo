import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:loo/loo.dart';

class TestState extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

void main() {
  test('register and get', () {
    final loo = Loo.instance;
    final state = TestState();
    loo.register(state);
    final result = loo.get<TestState>();
    expect(result, state);
  });
}
