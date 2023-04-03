import 'package:flutter/cupertino.dart';

class SizedBox8 extends StatelessWidget {
  factory SizedBox8() => _eagerInstance;

  const SizedBox8._();

  static const SizedBox8 _eagerInstance = SizedBox8._();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 8);
  }
}
