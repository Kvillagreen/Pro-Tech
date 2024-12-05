import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../pages/dashboard.dart';
import 'package:hotel/pages/extensions/string_extension.dart';
import 'package:hotel/tenants/tenantsFunction.dart';
import '../tenants/tenantsModel.dart';
import '../auth/connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class notification extends StatefulWidget {
  const notification({super.key});

  @override
  _notification createState() => _notification();
}

// ignore: camel_case_types
class _notification extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ProTech",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          backgroundColor: const Color(0xFF075292),
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
          },
        ),
        appBar: AppBar(
          title: const Text(
            "Notification",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          backgroundColor: const Color(0xFF075292),
          scrolledUnderElevation: 5.0,
          leading: Builder(
            builder: (context) => IconButton(
              padding: const EdgeInsets.only(bottom: 5),
              iconSize: MediaQuery.of(context).size.height * 0.04,
              icon: const Icon(Ionicons.arrow_back_sharp, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const dashboard(),
                  ),
                );
              },
            ),
          ),
        ),
        backgroundColor: const Color(0xFFafeeee),
        body: const notify(),
      ),
    );
  }
}

class notify extends StatefulWidget {
  const notify({super.key});

  @override
  _notify createState() => _notify();
}

// ignore: camel_case_types
class _notify extends State<notify> {
  var IDnum;
  Future UpdateReadMessage(BuildContext cont) async {
    try {
      var urlConn = "$url/notification/updateNotification.php";
      await http.post(
        Uri.parse(urlConn),
        body: {
          "tenants_id": IDnum.toString(),
        },
      );
      print(IDnum.toString());
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: notificationGet(),
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
                    "Notification",
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
                          child: user.notifier == "notify"
                              ? ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: ClipRRect(
                                        child: Image.network(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            "$mainUrl/uploads/uploadedImageTenant/${user.image}")),
                                  ),
                                  title: FittedBox(
                                    alignment: Alignment.topLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "${user.fname.toCapitalize()} ${user.lname.toCapitalize()}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      FittedBox(
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Account was created: \n${DateFormat('MM/dd/yyyy HH:mm').format(user.timestamp)}",
                                          style: const TextStyle(
                                            //${DateFormat('HH:mm:ss').format(user.timestamp)}
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      FittedBox(
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "User apply for room number: ${user.roomNumber}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 102, 156, 218))),
                                    onPressed: () {
                                      Fluttertoast.showToast(
                                          msg:
                                              "User ID number ${user.tenantsId} was removed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          fontSize: 16.0);
                                      IDnum = user.tenantsId;
                                      UpdateReadMessage(context);
                                    },
                                    icon: const Icon(
                                      Ionicons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: ClipRRect(
                                        child: Image.network(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            "$mainUrl/uploads/uploadedImageTenant/${user.image}")),
                                  ),
                                  title: FittedBox(
                                    alignment: Alignment.topLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "${user.fname.toCapitalize()} ${user.lname.toCapitalize()}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      FittedBox(
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "User status: ${user.status}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 102, 156, 218))),
                                    onPressed: () {
                                      Fluttertoast.showToast(
                                          msg:
                                              "User ID number ${user.tenantsId} was removed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          fontSize: 16.0);
                                      IDnum = user.tenantsId;
                                      UpdateReadMessage(context);
                                    },
                                    icon: const Icon(
                                      Ionicons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ));
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
                child: Text(
              "No notification",
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
