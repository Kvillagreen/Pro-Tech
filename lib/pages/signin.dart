// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';
import 'dashboard.dart';
import 'dart:convert';
import 'dart:async';
import 'extensions/string_extension.dart';
import 'package:ionicons/ionicons.dart';
import '../auth/connection.dart';

// ignore: prefer_typing_uninitialized_variables
var userName;
var userNameReal;
bool secureText = true;

// ignore: camel_case_types
class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signin();
}

// ignore: camel_case_types
class _signin extends State<signin> {
  var formkey = GlobalKey<FormState>();
  var username = TextEditingController();
  var useremail = TextEditingController();
  var userpassword = TextEditingController();
  var confirmuserpassword = TextEditingController();

  Future login(BuildContext cont) async {
    try {
      if (username.text == "" || userpassword.text == "") {
        Fluttertoast.showToast(
            msg: "All field is required!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      } else {
        var urlConn = "${url}signin.php";
        var response = await https.post(
          Uri.parse(urlConn),
          body: {
            "username": username.text,
            "password": userpassword.text,
          },
        );
        var data = await json.decode(json.encode(response.body));
        if (kDebugMode) {
          print(data);
        }

        print(data);
        if (data.toString().trim() == "true") {
          userName = username.text.toString().toCapitalize();
          userNameReal = username.text;
          Fluttertoast.showToast(
              msg: "Login Succesful!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const dashboard(),
            ),
          );
        } else {
          if (data.toString().trim() == "\"checked\"") {
            Fluttertoast.showToast(
                msg: "Password is incorrect!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "User does not exist! ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
          }
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(100, 7, 7, 7),
            Color.fromARGB(100, 25, 26, 25),
            Color.fromARGB(100, 65, 65, 65),
            Color.fromARGB(100, 25, 26, 25),
            Color.fromARGB(100, 7, 7, 7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: username,
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 211, 207, 207),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  prefixIcon: const Icon(
                    Icons.person,
                  ),
                  hintText: 'Username',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: userpassword,
              obscureText: secureText,
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 211, 207, 207),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      secureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        secureText = !secureText;
                      });
                    },
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(
              height: 15,
            ),
            CircleAvatar(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 211, 207, 207))),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        alignment: Alignment.center,                      ),
                      const Icon(
                        Ionicons.log_in,
                        color: Colors.black,
                        size: 20,
                      )
                    ],
                  ),
                  onPressed: () {
                    login(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.002,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'or',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.002,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const signUp()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(0, 211, 207, 207)),
              ),
              child: const Text(
                "Create new account",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
