import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provision_system/providers/AuthProvider.dart';
import 'package:provision_system/providers/ClientProvider.dart';
import 'package:provision_system/utils/commons.dart';
import 'package:provision_system/view/init/InitializeProviderDataScreen.dart';
import 'package:provision_system/view/login/login_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => ClientProvider())
    ],
      child: MaterialApp(
        title: 'Provision System',
        theme: appTheme,
        home: SplashScreen()));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

final appTheme = ThemeData(
  primaryColor: Commons.mainAppColor,
  accentIconTheme: IconThemeData(color: Colors.black),
  fontFamily: 'Roboto',
  hintColor: Commons.hintColor,
);

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  Future checkLoginStatus() async {
    final storage = FlutterSecureStorage();
    String loggedIn = await storage.read(key: "loginstatus");
    if (loggedIn == null || loggedIn == "loggedout") {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    } else {
      if (loggedIn == "loggedIn") {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => InitializeProviderDataScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset(
          'assets/images/flutter.png',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}