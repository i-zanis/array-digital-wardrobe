import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.primary;
    final progressColor = Theme.of(context).colorScheme.onPrimary;
    return LinearProgressIndicator(
      backgroundColor: backgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
      semanticsLabel: 'Loading',
    );
  }
}
