import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sharefiles_flutter/helpers/pocket_base_helper.dart';
import 'package:sharefiles_flutter/widgets/Logo.dart';

import '../../services/auth_service.dart';
import '../ClientExceptionDialog.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpWidget> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String passwordConfirm = '';
  int? pincode = null;

  void Register() async {
    UserModel result = await PocketBaseHelper().register(
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
    );

    await AuthService().storeEmail(email);
    await AuthService().storePassword(password, pincode ?? 0);

    await PocketBaseHelper()
        .client
        .users
        .authViaEmail(email, password);

    Navigator.pushReplacementNamed(context, "dashboard");
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100, 80, 100, 100),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  LogoWidget(),
                  const SizedBox(height: 34),
                  const Text(
                    'To get started, sign up.',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white, letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                      style: const TextStyle(color: Colors.grey),
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                        suffix: Text('For verification purposes'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please a valid email';
                        }

                        email = value;
                      }),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.grey),
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                            Icons.password_sharp, color: Colors.grey),
                        suffix: Text('Your backup authentication'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }

                        password = value;
                      }),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.grey),
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        hintText: 'Confirm password',
                        prefixIcon: Icon(
                            Icons.password_sharp, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (password != value) {
                          return 'Passwords do not match';
                        }

                        passwordConfirm = value;
                      }),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.grey),
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        hintText: 'Enter your pin',
                        prefixIcon: Icon(Icons.pin, color: Colors.grey),
                        suffix: Text('You\'ll login with this pin'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid pin';
                        }

                        pincode = int.parse(value);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account?',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: ' Login ',
                              ),
                              TextSpan(
                                  text: 'here!',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Navigator.pushReplacementNamed(
                                            context, "sign_in")),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              minimumSize: Size(90, 40)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                Register();
                              } on ClientException catch (e) {
                                AlertDialogWidget dialog = AlertDialogWidget(
                                  exception: e,
                                );

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return dialog;
                                  },
                                );
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
