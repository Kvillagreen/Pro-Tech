// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, duplicate_ignore, duplicate_ignore, non_constant_identifier_names, unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../pages/dashboard.dart';
import '../pages/signin.dart';
import 'bedroomModel.dart';
import 'bedroomFunction.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../auth/connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../tenants/tenantsFunction.dart';
import '../tenants/tenantsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_compare/image_compare.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

// value of the constant elevation and height
double elev = 2.0;
const double ht = 7.0;
const double rd = 25;
bool notifier = false;

class bedspaceForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _bedspaceForm createState() => _bedspaceForm();
}

String roomName = "";
String room_id = "";
String room_name = "";
String room_description = "";
String room_price = "";
String room_tenant = "";
String room_imageUrl = "";

// ignore: camel_case_types
class _bedspaceForm extends State<bedspaceForm> {
  var dirPath;
  late File _image;
  var dirPath1;
  late File _image1;
  var dirPath2;
  late File _image2;
  final picker = ImagePicker();
  var description = TextEditingController();
  var price = TextEditingController();

  Future addRoom(File imageFile,File imageFile1,File imageFile2) async {
    if (roomName == "" || description == "" || price == "") {
      Fluttertoast.showToast(
          msg: "All field are required!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    } else {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var stream1 = http.ByteStream(imageFile1.openRead());
      var length1 = await imageFile1.length();
      var stream2 = http.ByteStream(imageFile2.openRead());
      var length2 = await imageFile2.length();
      var uri = Uri.parse("$url/rooms/addRoom.php");
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile("image", stream, length,
          filename: (imageFile.path));
      
      var multipartFile1 = http.MultipartFile("image1", stream1, length1,
          filename: (imageFile1.path));

      var multipartFile2 = http.MultipartFile("image2", stream2, length2,
          filename: (imageFile2.path));

      request.files.add(multipartFile1);
      request.files.add(multipartFile2);
      request.files.add(multipartFile);
      request.fields['username'] = userNameReal;
      request.fields['roomName'] = roomName;
      request.fields['description'] = description.text;
      request.fields['price'] = price.text;

      var respond = await request.send();
      if (respond.statusCode == 200) {
        setState(() {
          roomName = "";
          description = TextEditingController();
          price = TextEditingController();
        });
        Fluttertoast.showToast(
            msg: "Room added succesfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    }
  }

  Future insertImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      dirPath = pickedImage.path;
    });
    print(pickedImage!.path);
  }
  Future insertImage1() async {
    var pickedImage1 = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image1 = File(pickedImage1!.path);
      dirPath1 = pickedImage1.path;
    });
    print(pickedImage1!.path);
  }
  Future insertImage2() async {
    var pickedImage2 = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image2 = File(pickedImage2!.path);
      dirPath2 = pickedImage2.path;
    });
    print(pickedImage2!.path);
  }

  var exapandable = false;
  _expansion(bool expanding) {
    setState(() {
      if (expanding) {
        exapandable = true;
      } else {
        exapandable = false;
      }
      print(exapandable);
    });
  }

  final _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProTech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Back",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          backgroundColor: Color(0xFF075292),
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
        body: Container(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  "ADD ROOM",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 254, 254),
                  border: exapandable == false
                      ? Border.all(width: 1, color: Colors.black)
                      : Border.all(
                          width: 0, color: const Color.fromARGB(0, 0, 0, 0)),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  child: ExpansionTile(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    collapsedBackgroundColor: const Color.fromARGB(0, 0, 0, 0),
                    onExpansionChanged: _expansion,
                    backgroundColor: Color.fromARGB(255, 255, 254, 254),
                    title: Text(
                      'Room type: $roomName',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    leading: Icon(
                      Ionicons.bed,
                      color: Colors.black,
                    ),
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                              backgroundColor: (_selectedIndex == 1
                                  ? MaterialStateProperty.all(
                                      const Color.fromARGB(88, 0, 0, 0))
                                  : MaterialStateProperty.all(
                                      const Color.fromARGB(0, 0, 0, 0)))),
                          child: const ListTile(
                            title: Text(
                              'Bi level',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              roomName = "Bi level";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                              backgroundColor: (_selectedIndex == 2
                                  ? MaterialStateProperty.all(
                                      const Color.fromARGB(88, 0, 0, 0))
                                  : MaterialStateProperty.all(
                                      const Color.fromARGB(0, 0, 0, 0)))),
                          child: const ListTile(
                            title: Text(
                              'Loft',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              roomName = "Loft";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                              backgroundColor: (_selectedIndex == 3
                                  ? MaterialStateProperty.all(
                                      const Color.fromARGB(88, 0, 0, 0))
                                  : MaterialStateProperty.all(
                                      const Color.fromARGB(0, 0, 0, 0)))),
                          child: const ListTile(
                            title: Text(
                              'Studio',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              roomName = "Studio";
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                              backgroundColor: (_selectedIndex == 3
                                  ? MaterialStateProperty.all(
                                      const Color.fromARGB(88, 0, 0, 0))
                                  : MaterialStateProperty.all(
                                      const Color.fromARGB(0, 0, 0, 0)))),
                          child: const ListTile(
                            title: Text(
                              'Penthouse',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              roomName = "Penthouse";
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                maxLines: 1,
                controller: description,
                decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 255, 254, 254),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    prefixIcon: const Icon(
                      Icons.text_format,
                      color: Colors.black,
                    ),
                    hintText: 'Description:',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                maxLines: 1,
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 255, 254, 254),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    prefixIcon: const Icon(
                      Icons.money_sharp,
                      color: Colors.black,
                    ),
                    hintText: 'Price:',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    shadowColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    overlayColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    surfaceTintColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 254, 254),
                      border: exapandable == false
                          ? Border.all(width: 1, color: Colors.black)
                          : Border.all(
                              width: 0,
                              color: const Color.fromARGB(0, 0, 0, 0)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        Container(child: Icon(Ionicons.camera)),
                        SizedBox(width: 5),
                        Container(
                          child: dirPath != "" ? Text("Select Image 1"): Text("Image selected"),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      insertImage();
                      print(dirPath);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    shadowColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    overlayColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    surfaceTintColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 254, 254),
                      border: exapandable == false
                          ? Border.all(width: 1, color: Colors.black)
                          : Border.all(
                              width: 0,
                              color: const Color.fromARGB(0, 0, 0, 0)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        Container(child: Icon(Ionicons.camera)),
                        SizedBox(width: 5),
                        Container(
                          child: Text("Select Image 2"),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      insertImage1();
                      print(dirPath1);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    shadowColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    overlayColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                    surfaceTintColor: MaterialStateProperty.all(
                        const Color.fromARGB(0, 0, 0, 0)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 254, 254),
                      border: exapandable == false
                          ? Border.all(width: 1, color: Colors.black)
                          : Border.all(
                              width: 0,
                              color: const Color.fromARGB(0, 0, 0, 0)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        Container(child: Icon(Ionicons.camera)),
                        SizedBox(width: 5),
                        Container(
                          child: Text("Select Image 3"),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      insertImage2();
                      print(dirPath2);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                child: CircleAvatar(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFF075292),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        addRoom(_image,_image1 ,_image2);
                      });
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class bedspace extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _bedspace createState() => _bedspace();
}

// ignore: camel_case_types
class _bedspace extends State<bedspace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: roomCheck(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                    "Rooms",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 2),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      room users = snapshot.data![index];
                      return Wrap(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(0, 0, 0, 0)),
                              shadowColor: MaterialStateProperty.all(
                                  const Color.fromARGB(0, 0, 0, 0)),
                              overlayColor: MaterialStateProperty.all(
                                  const Color.fromARGB(0, 0, 0, 0)),
                              surfaceTintColor: MaterialStateProperty.all(
                                  const Color.fromARGB(0, 0, 0, 0)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            onPressed: () {
                              setState(() {
                                room_id = users.roomNumber;
                                room_name = users.roomName;
                                room_description = users.description;
                                room_price = users.price;
                                room_tenant = users.tenantId;
                                room_imageUrl = users.image;

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => bedSpaceButton()),
                                );
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.fromLTRB(5, 8, 5, 0),
                              decoration: BoxDecoration(
                                color: users.status == "Available"
                                    ? Colors.blueAccent
                                    : Color.fromARGB(255, 83, 58, 223),
                                border: Border.all(
                                  width: 10,
                                  color: Color.fromARGB(0, 244, 67, 54),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Room Number: ${users.roomNumber}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 2),
                                  ListTile(
                                    leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            "$mainUrl/uploads/uploadedImageRoom/${users.image}")),
                                    title: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Text(
                                            "Type: ${users.roomName} ",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Text(
                                        "Price: Php ${users.price}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    trailing: users.status == "Available"
                                        ? Icon(Ionicons.lock_open,
                                            color: Colors.white, size: 30)
                                        : Icon(Ionicons.lock_closed,
                                            color: Colors.white, size: 30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class bedSpaceButton extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _bedSpaceButton createState() => _bedSpaceButton();
}

// ignore: camel_case_types
class _bedSpaceButton extends State<bedSpaceButton> {
  Future deleteRoom(BuildContext cont) async {
    var urlConn = "$url/rooms/deleteRoom.php";
    var response = await http.post(
      Uri.parse(urlConn),
      body: {"roomNumber": room_id},
    );
    var data = await json.decode(json.encode(response.body));
    if (data.toString() == "\"done\"") {
      Fluttertoast.showToast(
          msg: "Room $room_id deleted succesfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }
  }

  var read = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProTech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Room No: $room_id",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.29,
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      deleteRoom(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const dashboard(),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFF075292),
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
        body: FutureBuilder(
          future: tenantSingle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Wrap(
                direction: Axis.horizontal,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
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
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    "${mainUrl}uploads/uploadedImageRoom/$room_imageUrl"),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 1.5,
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 58, 118, 223),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Text(
                                        "TENANTS INFO:",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: Image.network(
                                            "$mainUrl/uploads/uploadedImageTenant/${user.image}",
                                          ),
                                        ),
                                      ),
                                      title: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "Name: ${user.fname} ${user.lname}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "Age: ${user.age}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "Gender: ${user.gender}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "Address: ${user.address}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "Contact Number: ${user.contactNo}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "Number of days: ${difference}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "From: ${user.fromdate}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),SizedBox(width: 5),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              "To: ${user.todate}",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                              textAlign: TextAlign.left,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 1.5,
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 58, 118, 223),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Text(
                                        "ROOM INFO:",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Text(
                                        "Room type: $room_name",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Text(
                                        "Price: Php $room_price",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          read = !read;
                                        });
                                        print(read);
                                      },
                                      child: read == false
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              child: Text(
                                                "Description: $room_description",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                                textAlign: TextAlign.left,
                                              ),
                                            )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              child: Text(
                                                "Description: $room_description",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                    ),
                                    SizedBox(height: 25),
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
              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 1,
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                            "$mainUrl/uploads/uploadedImageRoom/$room_imageUrl"),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 1.5,
                        padding: EdgeInsets.fromLTRB(30, 15, 10, 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 58, 118, 223),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 1.5,
                              padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 58, 118, 223),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1.5,
                                    padding:
                                        EdgeInsets.fromLTRB(10, 15, 10, 10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 58, 118, 223),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Text(
                                            "ROOM INFO:",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 5, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: Text(
                                            "Room type: $room_name",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 5, 0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: Text(
                                            "Price: Php $room_price",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(),
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              read = !read;
                                            });
                                            print(read);
                                          },
                                          child: read == false
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  child: Text(
                                                    "Description: $room_description",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  child: Text(
                                                    "Description: $room_description",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                        ),
                                        SizedBox(height: 25),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
/*

*/
