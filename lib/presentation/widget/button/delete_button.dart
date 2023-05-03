import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../core/route/app_route.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.onDelete});

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.tertiary),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.itemProfileScreenDialogDeleteTitle),
            content: Text(l10n.itemProfileScreenDialogDeleteMessage),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.itemProfileScreenDialogDeleteButtonCancel),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(l10n.itemProfileScreenDialogDeleteButtonDelete),
                onPressed: () {
                  onDelete();
                  AppNavigator.pop();
                  AppNavigator.push<void>(AppRoute.root);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
