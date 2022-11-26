import 'package:flutter/material.dart';

class SaveEditDialogWidget extends StatelessWidget {
  const SaveEditDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Are you sure you want to save edit?',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        TextButton(
            onPressed: () {},
            child: Text('Yes', style: Theme.of(context).textTheme.titleMedium)),
      ],
    );
  }
}
