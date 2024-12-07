# Loo

[![Pub Version](https://img.shields.io/pub/v/loo.svg)](https://pub.dev/packages/loo)

Loo é uma biblioteca de gerenciamento de estado para Flutter, projetada para ser simples e eficiente.

## Instalação

Adicione a dependência ao seu arquivo `pubspec.yaml`:

```yaml
dependencies:
  loo: ^0.0.2
```

Então, execute `flutter pub get` para instalar a nova dependência.

## Uso

### Registro de Estado

Para registrar um estado, use o método `register` da classe `Loo`:

```dart
import 'package:loo/loo.dart';

class MyState extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  List<Products> _products = [];
  List<Products> get products => _products;

  Future<void> getProductsFromApi() async {
    _products = await fetchedProducts();
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }
}

void main() {
  final loo = Loo.instance;
  final state = MyState();
  loo.register(state);
}
```

### Obtenção de Estado

Para obter um estado registrado, use o método `get` da classe `Loo`:

```dart
final myState = Loo.instance.get<MyState>();
```

### Atualização de UI

Para atualizar a UI quando o estado mudar, use o widget `LooView`:

```dart
import 'package:flutter/material.dart';
import 'package:loo/loo.dart';

void main() {
  final loo = Loo.instance.register(MyState());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LooView(
      child: MaterialApp(
        home: MyHomePage(),
      ),
      onInit: () {
        final myState = Loo.instance.get<MyState>();
        myState.getProductsFromApi();
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myState = Loo.instance.get<MyState>();
    final products = myState.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Loo Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter: ${myState.counter}',
            ),
            ElevatedButton(
              onPressed: myState.increment,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Testes

Para rodar os testes, use o comando:

```sh
flutter test
```

### Exemplo de Teste

```dart
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
```
