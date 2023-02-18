class ItemException implements Exception {
  ItemException({required this.message});

  String message;

  @override
  String toString() => message;
}
