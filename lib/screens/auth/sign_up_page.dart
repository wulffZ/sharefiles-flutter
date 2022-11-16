import 'package:flutter/material.dart';
import 'package:sharefiles_flutter/widgets/auth/sign_up.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body:  SignUpWidget(key: UniqueKey()),
    );
  }
}
