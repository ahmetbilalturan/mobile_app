import 'package:flutter/material.dart';
import 'package:test_app/pages/loading_page.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.blue.shade300,
      ),
      //route to homepage
      home: const LoadingPage(),
      //initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
