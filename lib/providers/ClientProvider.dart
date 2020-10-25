import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provision_system/models/client.dart';
import 'package:provision_system/utils/commons.dart';
import 'dart:async';

import 'package:requests/requests.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> clients;

  Future<List<Client>> fetchClientList() async {
    try {
      var token = await Commons.getAccessTokenFromStorage();
      final response = await Requests.post((Commons.baseUrl + "/upc/list"), headers: {'Authorization': "Bearer $token"});
      print(response);
      if (response.statusCode == 200) {
        var responseJson = response.json();
        clients = responseJson.map((clientJson) => Client.fromJson(clientJson)).toList();
        print(clients);
        return clients;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}