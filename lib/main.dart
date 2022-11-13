import 'package:flutter/material.dart';
import 'package:sharefiles_flutter/screens/loading.dart';
import 'package:pocketbase/pocketbase.dart';

final client = PocketBase('http://127.0.0.1:8090');

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
  },
));
