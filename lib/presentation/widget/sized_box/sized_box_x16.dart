import 'package:flutter/cupertino.dart';

class SizedBox16 extends StatelessWidget {
  factory SizedBox16() => _eagerInstance;

  const SizedBox16._();

  static const SizedBox16 _eagerInstance = SizedBox16._();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 16);
  }
}
