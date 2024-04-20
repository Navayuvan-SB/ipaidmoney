import 'package:flutter/material.dart';

void openDefaultBottomSheet(
    {required BuildContext context, required Widget child}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
    ),
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    builder: (context) {
      return child;
    },
  );
}
