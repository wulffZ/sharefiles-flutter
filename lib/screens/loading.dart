import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                  'sharefiles',
                  style: TextStyle(
                  fontSize: 44,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'now cross platform!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 35),
              SpinKitRing(color: Colors.white, size: 80.0),
            ]),
      ),
    );
  }
}
