import 'package:flutter/material.dart';
import 'package:hotel/pages/extensions/string_extension.dart';
import 'package:hotel/tenants/tenantsFunction.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import '../tenants/tenantsModel.dart';
import '../auth/connection.dart';

class tenantsRejected extends StatefulWidget {
  const tenantsRejected({super.key});

  @override
  State<tenantsRejected> createState() => _tenantsRejected();
}

// ignore: camel_case_types
class _tenantsRejected extends State<tenantsRejected> {
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
    return FutureBuilder(
      future: rejectedTenants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(
                    width: 10,
                    color: const Color.fromARGB(0, 244, 67, 54),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  "Rejected Tenants",
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
                  physics: const AlwaysScrollableScrollPhysics(),
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
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          width: 10,
                          color: const Color.fromARGB(0, 244, 67, 54),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: ClipRRect(
                                    child: Image.network(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                  height:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                            padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
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
                                    icon: const Icon(
                                      Ionicons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: IconButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 102, 156, 218))),
                                    onPressed: () {
                                      IDnum = user.tenantsId;
                                      status = "pending";
                                      UpdatePending(context);
                                      Fluttertoast.showToast(
                                          msg:
                                              "ID number: $IDnum \nStatus: ${status.toCapitalize()}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          fontSize: 16.0);
                                    },
                                    icon: const Icon(
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
          return const Center(
              child: Text(
            "No tenants",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ));
        }
      },
    );
  }
}
