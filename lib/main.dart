import 'package:flutter/material.dart';
import 'package:test_app/pages/loading_page.dart';
import 'package:test_app/route_generator.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

Future<bool> _onWillPop() async {
  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.blue.shade300,
        ),
        //route to homepage
        //home: LandingScreen(),
        home: const LoadingPage(),
        //initialRoute: '/loading',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
