class GlobalStateNotFoundException implements Exception {
  final Type type;
  GlobalStateNotFoundException(this.type);

  @override
  String toString() =>
      '[Loo] => Global state of type $type was not found. Make sure you registered it.';
}
