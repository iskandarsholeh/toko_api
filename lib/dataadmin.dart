// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.data,
  });

  List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.nama,
    this.username,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nama;
  String username;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nama: json["nama"],
    username: json["username"],
    password: json["password"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "username": username,
    "password": password,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
Future <Data>  fetchBoredActivity(String id) async {
  final response =
  await  http.get(Uri.https('127.0.0.1:8000', 'api/dataadmin'));
  if (response.statusCode == 200){
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Board Activity');
  }
}