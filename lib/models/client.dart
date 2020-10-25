import 'dart:ffi';

class Client {
  final String id;
  final int number;
  final String type;
  final Float core;
  final Float premium;
  final Float total;
  final String createdOn;

  Client({this.id, this.number, this.type, this.core, this.premium, this.total,
      this.createdOn});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      number: json['number'],
      type: json['type'],
      core: json['core'],
      premium: json['premium'],
      total: json['total'],
      createdOn: json['created_on']
    );
  }

  @override
  String toString() {
    return "$id | $number | $type | $core";
  }
}