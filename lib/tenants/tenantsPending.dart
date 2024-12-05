// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:hotel/pages/extensions/string_extension.dart';
import 'package:hotel/tenants/tenantsFunction.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import '../pages/setting.dart';
import '../tenants/tenantsModel.dart';
import '../auth/connection.dart';

// value of the constant elevation and height
double elev = 2.0;
const double ht = 7.0;
const double rd = 30;
bool notifier = false;

// ignore: camel_case_types
class tenantsPending extends StatefulWidget {
  const tenantsPending({super.key});

  @override
  State<tenantsPending> createState() => _tenantsPending();
}

// ignore: camel_case_types
class _tenantsPending extends State<tenantsPending> {
  var IDnum;
  String status = "";
  Future UpdatePending(BuildContext cont) async {
    try {
      var urlConn = "${url}tenants/update_pending.php";
      await http.post(
        Uri.parse(urlConn),
        body: {
          "tenants_id": IDnum.toString(),
          "status": status.toString(),
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: pendingTenants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1,
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      width: 10,
                      color: Color.fromARGB(0, 244, 67, 54),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    "Pending Tenants",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      Tenants user = snapshot.data![index];

                      int daysBetween() {
                        if (user.fromdate != '' && user.todate != '') {
                          DateTime from = DateTime.parse(user.fromdate);
                          DateTime to = DateTime.parse(user.todate);
                          return (to.difference(from).inHours / 24).round();
                        }
                        else{
                          return (0).round();
                        }
                      }

                      final difference = daysBetween();

                      return Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(
                            width: 10,
                            color: Color.fromARGB(0, 244, 67, 54),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                  child: ClipRRect(
                                      child: Image.network(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          "$mainUrl/uploads/uploadedImageTenant/${user.image}")),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                  child: Text(
                                    "ID Number: \n${user.tenantsId}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "${user.fname.toCapitalize()} ${user.lname.toCapitalize()}",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Age: ${user.age}\t\t\t Gender: ${user.gender} ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Address: ${user.address}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Contact No.: ${user.contactNo}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Room No.:${user.roomNumber}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Time: ${user.timestamp} ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: Text(
                                      "Number of days: ${difference}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 102, 156, 218))),
                                      onPressed: () {
                                        IDnum = user.tenantsId;
                                        status = "rejected";
                                        UpdatePending(context);
                                        Fluttertoast.showToast(
                                            msg:
                                                "ID number: $IDnum \nStatus: ${status.toCapitalize()}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            fontSize: 16.0);
                                      },
                                      icon: Icon(
                                        Ionicons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.025,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: IconButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 102, 156, 218))),
                                      onPressed: () {
                                        IDnum = user.tenantsId;
                                        status = "approved";
                                        UpdatePending(context);
                                        Fluttertoast.showToast(
                                            msg:
                                                "ID number: $IDnum \nStatus: ${status.toCapitalize()}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            fontSize: 16.0);
                                      },
                                      icon: Icon(
                                        Ionicons.checkmark,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Text(
              "No tenants",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ));
          }
        },
      ),
    );
  }
}