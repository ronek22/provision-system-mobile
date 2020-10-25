import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provision_system/models/user.dart';
import 'package:provision_system/networking/AppException.dart';
import 'package:provision_system/view/login/login_screen.dart';
import 'package:http/http.dart' as http;

class Commons {
  static const hostname = "158.101.165.3";
  static const baseUrl = "http://$hostname/api/";

  static const tileBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeWaveBackgroundColor = const Color(0xFFA8184B);
  static const gradientBackgroundColorEnd = const Color(0xFF601A36);
  static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  static const mainAppFontColor = const Color(0xFF4D0F29);
  static const appBarBackGroundColor = const Color(0xFF4D0F28);
  static const categoriesBackGroundColor = const Color(0xFFA8184B);
  static const hintColor = const Color(0xFF4D0F29);
  static const mainAppColor = const Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = const Color(0xFF4D0F29);
  static const popupItemBackColor = const Color(0xFFDADADB);

  static Widget chuckyLoader() {
    return Center(child: SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(decoration: BoxDecoration(
          color: index.isEven ? Color(0xFFFFFFF) : Color(0xFF311433),
        ),
        );
      },
    ));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(message),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  static Widget chuckyLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(18), child: Text(message)),
        chuckyLoader(),
      ],
    );
  }

  static Future logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  static Future<String> getAccessTokenFromStorage() async {
    final storage = FlutterSecureStorage();
    var user = User.fromJson(jsonDecode(await storage.read(key: 'user')));
    return user.accessToken;
  }

  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}