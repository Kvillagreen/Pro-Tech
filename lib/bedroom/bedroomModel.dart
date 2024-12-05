// ignore_for_file: camel_case_types

import 'dart:convert';

List<room> roomFromJson(String str) =>
    List<room>.from(json.decode(str).map((x) => room.fromJson(x)));

String roomToJson(List<room> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class room {
  String roomNumber;
  String roomName;
  String description;
  String price;
  String ownerId;
  String tenantId;
  String status;
  String image;
  String image1;
  String image2;

  room({
    required this.roomNumber,
    required this.roomName,
    required this.description,
    required this.price,
    required this.ownerId,
    required this.tenantId,
    required this.status,
    required this.image,
    required this.image1,
    required this.image2,
  });

  factory room.fromJson(Map<String, dynamic> json) => room(
        roomNumber: json["roomNumber"],
        roomName: json["roomName"],
        description: json["description"],
        price: json["price"],
        ownerId: json["ownerId"],
        tenantId: json["tenantId"],
        status: json["status"],
        image: json["image"],
        image1: json["image1"],
        image2: json["image2"],
      );

  Map<String, dynamic> toJson() => {
        "roomNumber": roomNumber,
        "roomName": roomName,
        "description": description,
        "price": price,
        "ownerId": ownerId,
        "tenantId": tenantId,
        "status": status,
        "image": image,
        "image1": image1,
        "image2": image2,
      };
}
