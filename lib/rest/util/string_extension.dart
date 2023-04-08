extension StringExtensions on String? {
  String defaultIfEmpty([String defaultValue = '']) {
    if (this == null || this!.isEmpty) return defaultValue;
    return this!;
  }
}
