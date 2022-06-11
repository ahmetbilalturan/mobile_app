import 'package:flutter/material.dart';
import 'package:test_app/route_generator.dart';
import 'mongodb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
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
      ),
      //route to homepage
      initialRoute: '/homepage',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
