class ObserverException implements Exception {

  final String cause;

  ObserverException(this.cause);

  @override
  String toString() {
    return 'ObserverException: $cause';
  }
}