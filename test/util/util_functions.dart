import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns true for expired data', () {
    final lastFetched = DateTime.now().subtract(const Duration(days: 1));
    const timeToLive = Duration(hours: 1);

    final result = isStale(lastFetched, timeToLive);

    expect(result, isTrue);
  });

  test('returns false for fresh data', () {
    final lastFetched = DateTime.now();
    const timeToLive = Duration(hours: 1);

    final result = isStale(lastFetched, timeToLive);

    expect(result, isFalse);
  });
}
