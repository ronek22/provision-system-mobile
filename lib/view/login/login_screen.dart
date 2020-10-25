import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provision_system/models/user.dart';
import 'package:provision_system/providers/AuthProvider.dart';
import 'package:provision_system/utils/commons.dart';
import 'package:provision_system/view/init/InitializeProviderDataScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
  TextEditingController _userName;
  TextEditingController _userPassword;
  final _formPageKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _userName = TextEditingController(text: "");
    _userPassword = TextEditingController(text: "");
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _pageKey,
      body: Form(
          key: _formPageKey,
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: SizedBox(),
                          ),
                          Text(
                            "Login to Provison System",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'
                            ),
                          ),
                          SizedBox(height: 50,),
                          _usernamePasswordWidget(),
                          SizedBox(height: 20),
                          _loginButton(),
                          SizedBox(height: 20,),
                          _divider(),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          )
      ),
    );
  }

  Widget _loginButton() {
    return isLoading
        ? Center(
      child: Commons.chuckyLoading("Loggin in..."),
    )
        : GestureDetector(
      onTap: () async {
        if (_formPageKey.currentState.validate()) {
          setState(() {
            isLoading = false; // FOR TESTING PURPOSE DONT CHANGE STATE
          });
          try {
            final newUser = Provider.of<AuthProvider>(context, listen: false).login(_userName.text, _userPassword.text);
            if (newUser != null) {
              _login(await newUser);
            }
          } catch (e) {
            Commons.showError(context, e.message);
            setState(() => isLoading = false);
            _pageKey.currentState.showSnackBar(
                SnackBar(content: Text("Could not login")));
          }
        }
      },
      child: Container(
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Commons.gradientBackgroundColorStart,
                  Commons.gradientBackgroundColorEnd])),
      ),
    );
  }

  _login(User user) {
    final storage = FlutterSecureStorage();
    storage.write(key: 'user', value: jsonEncode(user));
    storage.write(key: "loginstatus", value: "loggedin");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => InitializeProviderDataScreen()));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      key: Key("userName"),
      controller: _userName,
      validator: (value) => (value.isEmpty) ? "Please enter username" : null,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_box),
        labelText: "Username",
        border: OutlineInputBorder()),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      key: Key("userPassword"),
      controller: _userPassword,
      obscureText: _obscureText,
      validator: (value) => (value.isEmpty) ? "Please enter password" : null,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: "Password",
        border: OutlineInputBorder()),
    );
  }

  Widget _usernamePasswordWidget() {
    return Column(
      children: <Widget>[
        _usernameField(),
        SizedBox(height: 10,),
        _passwordField(),
        FlatButton(onPressed: _togglePassword, child: new Text(_obscureText ? "Show" : "Hide")),
      ],
    );
  }





}
