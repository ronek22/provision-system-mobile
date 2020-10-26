import 'dart:ffi';

class Client {
  final int id;
  final int number;
  final String type;
  final double core;
  final double premium;
  final double total;
  final String createdOn;

  Client({this.id, this.number, this.type, this.core, this.premium, this.total,
      this.createdOn});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      number: json['number'],
      type: json['type'],
      core: double.parse(json['core']),
      premium: double.parse(json['premium']),
      total: double.parse(json['total']),
      createdOn: json['created_on']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'type': type,
    'core': core,
    'premium': premium,
    'total': total
  };

  @override
  String toString() {
    return "$type | $number | $core";
  }
}