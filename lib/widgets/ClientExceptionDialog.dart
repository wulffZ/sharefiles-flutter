import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class AlertDialogWidget extends StatelessWidget {
  final ClientException exception;

  const AlertDialogWidget({super.key, required this.exception});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Something went wrong.'),
      content: Text(
          '${this.exception.response['message']}'
      ),
    );
  }
}