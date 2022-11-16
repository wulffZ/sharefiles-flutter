import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.upload_rounded,
                          size: 24, color: Colors.white),
                    ),
                    TextSpan(
                        text: "sharefiles",
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            letterSpacing: 2.0)),
                    WidgetSpan(
                      child: Icon(Icons.download_rounded,
                          size: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Text(
                'Now cross-platform!',
                style: TextStyle(
                    fontSize: 12, color: Colors.white, letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
