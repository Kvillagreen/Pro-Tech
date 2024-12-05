// To parse this JSON data, do
//
//     final tenants = tenantsFromJson(jsonString);

import 'dart:convert';

List<Tenants> tenantsFromJson(String str) => List<Tenants>.from(json.decode(str).map((x) => Tenants.fromJson(x)));

String tenantsToJson(List<Tenants> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tenants {
    String tenantsId;
    String fname;
    String lname;
    String username;
    String password;
    String address;
    String contactNo;
    String gender;
    String age;
    String roomNumber;
    String ownerRoomID;
    String image;
    String validId;
    DateTime timestamp;
    String status;
    String notifier;
    String adminImageCapture;
    String fromdate;
    String todate;

    Tenants({
        required this.tenantsId,
        required this.fname,
        required this.lname,
        required this.username,
        required this.password,
        required this.address,
        required this.contactNo,
        required this.gender,
        required this.age,
        required this.roomNumber,
        required this.ownerRoomID,
        required this.image,
        required this.validId,
        required this.timestamp,
        required this.status,
        required this.notifier,
        required this.adminImageCapture,
        required this.fromdate,
        required this.todate,
    });

    factory Tenants.fromJson(Map<String, dynamic> json) => Tenants(
        tenantsId: json["tenants_id"],
        fname: json["fname"],
        lname: json["lname"],
        username: json["username"],
        password: json["password"],
        address: json["address"],
        contactNo: json["contact_no"],
        gender: json["gender"],
        age: json["age"],
        roomNumber: json["room_number"],
        ownerRoomID: json["ownerRoomID"],
        image: json["image"],
        validId: json["valid_id"],
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        notifier: json["notifier"],
        adminImageCapture: json["adminImageCapture"],
        fromdate: json["fromdate"],
        todate: json["todate"],
    );

    Map<String, dynamic> toJson() => {
        "tenants_id": tenantsId,
        "fname": fname,
        "lname": lname,
        "username": username,
        "password": password,
        "address": address,
        "contact_no": contactNo,
        "gender": gender,
        "age": age,
        "room_number": roomNumber,
        "ownerRoomID": ownerRoomID,
        "image": image,
        "valid_id": validId,
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "notifier": notifier,
        "admin": adminImageCapture,
        "fromdate": fromdate,
        "todate": todate,
    };
}
