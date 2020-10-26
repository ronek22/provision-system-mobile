import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provision_system/models/user.dart';
import 'package:provision_system/utils/commons.dart';
import 'package:requests/requests.dart';

import 'ClientProvider.dart';


class AuthProvider extends ChangeNotifier {
  User user;

  Future<User> login(String username, String password) async {
    try {
      var response = await Requests.post((Commons.baseUrl + "accounts/login"), body: {"username": username, "password": password});
      if (response.success) {
        var cookies = await Requests.getStoredCookies(Commons.hostname);
        var responseJson = response.json();
        user = User.fromJson(responseJson['user']);
        user.accessToken = responseJson['access_token'];
        user.refreshToken = cookies['refreshtoken'];
        print(user);
        return user;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}

