import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provision_system/models/client.dart';
import 'package:provision_system/providers/ClientProvider.dart';
import 'package:provision_system/utils/commons.dart';
import 'package:provision_system/view/client/clients.view.dart';
import 'package:provision_system/utils/error.dart';

class InitializeProviderDataScreen extends StatefulWidget {
  InitializeProvidersState createState() => InitializeProvidersState();
}

class InitializeProvidersState extends State<InitializeProviderDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loadClients());
  }


  Widget _loadClients() {
    return FutureBuilder<List<Client>>(
      future: Provider.of<ClientProvider>(context, listen: false).fetchClientList(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return Text(
          'Fetch opportunity data',
            textAlign: TextAlign.center,
        );
        case ConnectionState.active:
          return Text('');
        case ConnectionState.waiting:
          return Commons.chuckyLoading("Fetching Clients...");
        case ConnectionState.done:
          if (snapshot.hasError) {
            return Error(
              errorMessage: "Error retrieving Clients ${snapshot.error}", onRetryPressed: () => Commons.logout(context)
            );
        } else {
            return GetClients();
        }
        }
        return Commons.chuckyLoading("Fetching clients...");
      },
    );
  }
}