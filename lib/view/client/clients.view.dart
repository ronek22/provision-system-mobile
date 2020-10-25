import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provision_system/models/client.dart';
import 'package:provision_system/providers/ClientProvider.dart';
import 'package:provision_system/utils/commons.dart';

class GetClients extends StatefulWidget {
  @override
  _GetClientsState createState() => _GetClientsState();
}

class _GetClientsState extends State<GetClients> {
  List<Client> clients;

  @override
  void initState() {
    clients = Provider.of<ClientProvider>(context, listen: false).clients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Clients list',
          style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Commons.appBarBackGroundColor,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Commons.logout(context);
            },
            child: Text("Logout"),
            shape:
              CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ]),
      backgroundColor: Color(0xFF333333),
      body: ClientList(clientList: clients));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ClientList extends StatelessWidget {
  final List<Client> clientList;

  const ClientList({Key key, this.clientList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commons.categoriesBackGroundColor,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 0.5
            ),
            child: InkWell(
              onTap: () {
                print("CLICKED");
            },
            child: SizedBox(
              height: 65,
              child: Container(
                color: Commons.tileBackgroundColor,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4,0,0,0),
                  child: Text(
                    clientList[index].type,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto'),
                    textAlign: TextAlign.left,
                  )
                )
              )
            ),
            ),
          );
        },
        itemCount: clientList.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}