import 'package:Array_App/config/style_config.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(StyleConfig.paddingS),
      child: FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        child: Icon(icon),
      ),
    );
  }
}
