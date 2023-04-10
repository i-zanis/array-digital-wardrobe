import 'package:Array_App/config/style_config.dart';
import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tooltip,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        child: Icon(icon),
      ),
    );
  }
}
