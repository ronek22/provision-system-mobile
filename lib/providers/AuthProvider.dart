import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provision_system/models/user.dart';
import 'package:provision_system/utils/commons.dart';
import 'package:requests/requests.dart';


class AuthProvider extends ChangeNotifier {
  User user;

  Future<User> login(String username, String password) async {
    try {
      var response = await Requests.post((Commons.baseUrl + "accounts/login"), body: {"username": username, "password": password});
      if (response.success) {
        var cookies = await Requests.getStoredCookies(Commons.hostname);
        user = User.fromJson(response.json());
        user.refreshToken = cookies['refreshtoken'];
        return user;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}

