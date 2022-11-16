import 'package:flutter/material.dart';
import 'package:sharefiles_flutter/widgets/auth/sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() {
    return SignInPageState();
  }
}

class SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body:  SignInWidget(key: UniqueKey()),
    );
  }
}
