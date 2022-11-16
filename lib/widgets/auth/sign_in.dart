import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:sharefiles_flutter/helpers/pocket_base_helper.dart';
import 'package:sharefiles_flutter/widgets/ClientExceptionDialog.dart';
import 'package:sharefiles_flutter/widgets/Logo.dart';
import 'package:sharefiles_flutter/services/auth_service.dart';
import 'package:sharefiles_flutter/widgets/GeneralDialog.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignInWidget> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _formKeyPin = GlobalKey<FormState>();

  bool loginWithPin = true;
  String email = '';
  String password = '';
  String enteredPincode = '';
  int? pincode = null;

  void Login() async {
    if (loginWithPin) {
      // Decrypt pw with pin
      email = await AuthService().getStoredEmail();
      password = await AuthService().decryptPassword(pincode ?? 0);
    }
    // Login regularly
    try {
      await PocketBaseHelper().client.users.authViaEmail(email, password);

      Navigator.pushReplacementNamed(context, "dashboard");
    } on ClientException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogWidget(exception: e);
        },
      );

      enteredPincode = '';
    }
  }

  _onKeyboardTap(String value) {
    setState(() {
      enteredPincode += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginWithPin == true) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(100, 80, 100, 100),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LogoWidget(),
              const SizedBox(height: 34),
              NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textColor: Colors.grey,
                  rightButtonFn: () {
                    setState(() {
                      if (enteredPincode.isNotEmpty) {
                        enteredPincode = enteredPincode.substring(
                            0, enteredPincode.length - 1);
                      }
                    });
                  },
                  rightIcon: const Icon(
                    Icons.backspace,
                    color: Colors.deepOrange,
                  ),
                  leftButtonFn: () {
                    if (enteredPincode.length < 4) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const GeneralDialogWidget(
                                title: 'No pin',
                                message:
                                    'Please enter a valid 4 character pin');
                          });
                    } else {
                      pincode = int.parse(enteredPincode);
                      Login();
                    }
                  },
                  leftIcon: const Icon(
                    Icons.check,
                    color: Colors.deepOrange,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'No pin?',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' click ',
                          ),
                          TextSpan(
                            text: 'here!',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => setState(() => {
                                loginWithPin = false,
                              }),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'No account yet?',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' Register ',
                          ),
                          TextSpan(
                              text: 'here!',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacementNamed(
                                    context, "sign_up")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    } else {
      return Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(100, 80, 100, 100),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LogoWidget(),
              const SizedBox(height: 34),
              TextFormField(
                  style: const TextStyle(color: Colors.grey),
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
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
                    prefixIcon: Icon(Icons.password_sharp, color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    password = value;
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Register ',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'here!',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushReplacementNamed(
                                    context, "sign_up")),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Use pin?',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: ' click ',
                              ),
                              TextSpan(
                                text: 'here!',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => setState(() => {
                                    loginWithPin = true,
                                  }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                minimumSize: Size(90, 40)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Login();
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    }
  }
}
