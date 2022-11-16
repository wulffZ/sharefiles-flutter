import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralDialogWidget extends StatelessWidget {
  final String title;
  final String message;

  const GeneralDialogWidget({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
    );
  }
}