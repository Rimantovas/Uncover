import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uncoverapp/Screens/HomePage.dart';
import 'package:provider/provider.dart';

void main() async {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) => runApp(MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple[900],
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(
              brightness: Brightness.dark,
              primary: Colors.purple,
            )
            .copyWith(secondary: Colors.purpleAccent),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Container(
        child: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  //SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    Timer(Duration(seconds: 2), () {
      startingPage(context); //It will redirect  after 3 seconds
    });
  }

  Future<void> startingPage(BuildContext context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Image(
            image: AssetImage('assets/logo/Uncover.png'),
          ),
        ),
      ),
    );
  }
}
