import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provision_system/models/chuck_clients.dart';
import 'package:provision_system/utils/commons.dart';
import 'dart:async';

import 'package:requests/requests.dart';

class ClientProvider extends ChangeNotifier {
  ChuckClients chuckClients;

  Future<ChuckClients> fetchClientList() async {
    try {
      var token = await Commons.getAccessTokenFromStorage();
      final response = await Requests.get((Commons.baseUrl + "/upc/list"), headers: {'Authorization': "Bearer $token"});
      if (response.success) {
        chuckClients = ChuckClients.fromJson(response.json());
        return chuckClients;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}