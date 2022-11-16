import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sharefiles_flutter/screens/auth/sign_in_page.dart';
import 'package:sharefiles_flutter/screens/auth/sign_up_page.dart';
import 'package:sharefiles_flutter/helpers/pocket_base_helper.dart';
import 'package:sharefiles_flutter/screens/dashboard.dart';

void main() async {
  await dotenv.load();

  PocketBaseHelper().setPocketbaseUrl(dotenv.env['POCKETBASE_URL'] ?? "");
  runApp(sharefiles());
}

class sharefiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
      routes: {
        'sign_up': (context) => SignUpPage(),
        'sign_in': (context) => SignInPage(),
        'dashboard': (context) => Dashboard(),
      },

      title: 'sharefiles - upload and share',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0)),
          hintStyle:
              TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1.0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 0.0),
          ),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 45.0,
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Montserrat',
          ),
          titleMedium: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      home: SignUpPage(),
    );
  }
}
