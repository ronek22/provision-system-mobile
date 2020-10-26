import 'client.dart';

class ChuckClients {
  final List<Client> clients;

  ChuckClients({this.clients});

  factory ChuckClients.fromJson(List<dynamic> json) {
    return ChuckClients(
      clients: json != null ? json.map((i) => Client.fromJson(i)).toList() : null,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> data = new List<Client>();
    if(this.clients != null) {
      data = this.clients;
    }
    return data;
  }
}