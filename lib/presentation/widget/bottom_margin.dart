import 'package:flutter/cupertino.dart';

class BottomMargin extends StatelessWidget {
  const BottomMargin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
    );
  }
}
