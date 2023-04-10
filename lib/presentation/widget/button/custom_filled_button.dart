import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.content,
    this.icon,
  });

  final VoidCallback onPressed;
  final String content;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 40),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
      onPressed: onPressed,
      child: Text(content),
    );
  }
}
