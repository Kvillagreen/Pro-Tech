// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../auth/connection.dart';
import '../main.dart';
import 'dart:convert';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUp();
}

// ignore: camel_case_types
class _signUp extends State<signUp> {
  var formkey = GlobalKey<FormState>();
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
  var _height = 0.45;

  Future register(BuildContext cont) async {
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
          var urlConnect = "${url}signup.php";
          var response = await http.post(
            Uri.parse(urlConnect),
            body: {
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
          if (data.toString().trim() == "\"signup\"") {
            Fluttertoast.showToast(
                msg: "Register Succesful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
            // ignore: use_build_context_synchronously
            Navigator.push(
                cont, MaterialPageRoute(builder: (context) => const ProTech()));
          } else if (data.toString().trim() == "\"exist\"") {
            Fluttertoast.showToast(
                msg: "Username Already Used",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Data error",
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
    return Material(
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainBackground.jpg"),
            alignment: Alignment.center,
            opacity: 0.8,
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 7, 7, 7),
              Color.fromARGB(255, 25, 26, 25),
              Color.fromARGB(255, 65, 65, 65),
              Color.fromARGB(255, 91, 92, 91),
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height * _height,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
            ),
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const Center(
                  child: Text(
                    "REGISTRATION",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        controller: fname,
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                      width: MediaQuery.of(context).size.width * 0.001,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.44,
                      child: TextField(
                        scrollPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).viewInsets.bottom),
                        controller: lname,
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                      fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                      fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                      fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 211, 207, 207),
                  ),
                  child: Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 211, 207, 207)),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.height * 0.04,
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
                              const Color.fromARGB(255, 211, 207, 207)),
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
                                  const Color.fromARGB(255, 116, 114, 114))
                              : MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 211, 207, 207)),
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
                                  const Color.fromARGB(255, 116, 114, 114))
                              : MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 211, 207, 207)),
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
                      fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                        fillColor: const Color.fromARGB(255, 211, 207, 207),
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
                  height: 7,
                ),
                CircleAvatar(
                  child: ElevatedButton(
                    onPressed: () {
                      register(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 211, 207, 207)),
                    ),
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.002,
                        width: MediaQuery.of(context).size.width * 0.36,
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
                        width: MediaQuery.of(context).size.width * 0.36,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProTech(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(0, 211, 207, 207)),
                  ),
                  child: const Text(
                    "Already have an account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
