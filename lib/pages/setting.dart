// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore, non_constant_identifier_names, unused_import, camel_case_types

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/auth/connection.dart';
import 'package:hotel/main.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'signin.dart';

// value of the constant elevation and height
double elev = 2.0;
const double ht = 7.0;
const double rd = 25;
bool notifier = false;

// ignore: camel_case_types
class settingpage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _settingpage createState() => _settingpage();
}

class _settingpage extends State<settingpage> {
  var username = TextEditingController();
  var userpassword = TextEditingController();
  var confirmuserpassword = TextEditingController();
  var fname = TextEditingController();
  var lname = TextEditingController();
  var contact_no = TextEditingController();
  var gender = "male";
  int age = 18;
  var address = TextEditingController();

  bool secureText = true;
  bool _secureText = true;

  Future update(BuildContext cont) async {
    try {
      if (username.text == "" ||
          userpassword.text == "" ||
          confirmuserpassword.text == "" ||
          fname.text == "" ||
          lname == "" ||
          contact_no == "" ||
          gender == "" ||
          age == "" ||
          address == "") {
        Fluttertoast.showToast(
            msg: "All field is required!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      } else {
        if (userpassword.text == confirmuserpassword.text) {
          var urlConnect = "${url}update.php";
          var response = await http.post(
            Uri.parse(urlConnect),
            body: {
              "oldusername": userNameReal.toString(),
              "username": username.text,
              "password": userpassword.text,
              'fname': fname.text,
              'lname': lname.text,
              'address': address.text,
              'contact_no': contact_no.text,
              'gender': gender,
              'age': age.toString(),
            },
          );
          var data = await json.decode(json.encode(response.body));
          if (kDebugMode) {
            print(data);
          }
          print(data);
          if (data.toString().trim() == "\"updated\"") {
            await Fluttertoast.showToast(
                msg: "Update succesful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
            await Fluttertoast.showToast(
                msg: "Route back login page!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
            // ignore: use_build_context_synchronously
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProTech(),
              ),
            );
          } else {
            Fluttertoast.showToast(
                msg: "Error received while updating",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Password should be the same!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
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
              "UPDATE INFORMATION",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextField(
                        controller: fname,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            hintText: 'First Name',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: TextField(
                        scrollPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).viewInsets.bottom),
                        controller: lname,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            hintText: 'Last Name',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                      hintText: 'Username',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: userpassword,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _secureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () async {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: confirmuserpassword,
                  obscureText: secureText,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          secureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () async {
                          setState(() {
                            secureText = !secureText;
                          });
                        },
                      ),
                      hintText: 'Confirm password',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            if (age > 0) {
                              age--;
                            }
                          });
                        },
                      ),
                      Container(
                        child: Text(
                          "Age: $age",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            age++;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: gender == "male"
                              ? MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 158, 142, 142),
                                )
                              : MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Text("M",style:TextStyle(fontSize:16,color: Colors.black))
                        ),
                        onPressed: () async {
                          setState(() {
                            gender = "male";
                          });
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: gender == "female"
                              ? MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 158, 142, 142),
                                )
                              : MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Text("F",style:TextStyle(fontSize:16,color: Colors.black))
                        ),
                        onPressed: () async {
                          setState(() {
                            gender = "female";
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  controller: contact_no,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: const Icon(
                        Icons.numbers,
                        color: Colors.black,
                      ),
                      hintText: 'Contact No.',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  child: TextField(
                    maxLines: 1,
                    controller: address,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        prefixIcon: const Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        hintText: 'Address',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    update(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(100, 50),
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(fontSize: 19, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
