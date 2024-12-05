import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel/pages/notification.dart';
import 'package:ionicons/ionicons.dart';
import '../bedroom/roompage.dart';
import '../tenants/tenantsPending.dart';
import '../tenants/tenantsRejected.dart';
import '../tenants/tenantsApproved.dart';
import 'signin.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'setting.dart';
import '../main.dart';
import '../auth/connection.dart';

String? categoryValue;
int rev = 0;
var navBarColor = 0xFF075292;
var notificationCheck = "0";

// ignore: camel_case_types
class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _dashboard createState() => _dashboard();
}

// ignore: camel_case_types
int _selectedIndex = 0;

class _dashboard extends State<dashboard> {
  void _navigatorBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future logout(BuildContext cont) async {
    try {
      var urlConn = "${url}logout.php";
      var response = await http.post(
        Uri.parse(urlConn),
        body: {},
      );
      var data = await json.decode(json.encode(response.body));

      if (data.toString() == "\"logout\"") {
        userName = "";
        Fluttertoast.showToast(
            msg: "Logout Succesful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProTech(),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final List<Widget> _pages = [
    bedspace(),
    const tenantsPending(),
    const tenantsApproved(),
    const tenantsRejected(),
    settingpage()
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 25), (Timer t) async {
      var urlConn = "${url}notification/notificationViewer.php";
      var response = await http.get(
        Uri.parse(urlConn),
      );
      notificationCheck = await json.decode(json.encode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            heroTag: null,
            backgroundColor: const Color(0xFF075292),
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            }),
        SizedBox(
          height: 10,
        ),
        _selectedIndex == 0
            ? FloatingActionButton(
                backgroundColor: const Color(0xFF075292),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => bedspaceForm()));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : const Text(""),
      ]),
      appBar: AppBar(
        backgroundColor: Color(navBarColor),
        scrolledUnderElevation: 5.0,
        leading: Builder(
          builder: (context) => IconButton(
            padding: const EdgeInsets.only(bottom: 5),
            iconSize: MediaQuery.of(context).size.height * 0.06,
            icon: const Icon(Ionicons.menu_outline, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.all(0),
          child: Row(children: [
            const Text(
              "ProTech",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
            ),
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    notificationCheck,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  splashRadius: 50,
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const notification()));
                  },
                  icon: Icon(
                    Ionicons.notifications,
                    color: notificationCheck == "0"
                        ? Colors.white
                        : Color.fromARGB(255, 151, 21, 12),
                    size: 30,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
      drawer: Drawer(
        key: _scaffoldKey,
        semanticLabel: 'ProTech',
        elevation: 10,
        backgroundColor: const Color(0xFFafeeee),
        width: MediaQuery.of(context).size.width * 0.75,
        child:
            ListView(physics: const NeverScrollableScrollPhysics(), children: [
          Material(
            borderOnForeground: false,
            animationDuration: const Duration(seconds: 6),
            surfaceTintColor: Colors.black,
            child: Container(
              color: Color(navBarColor),
              height: MediaQuery.of(context).size.height * 0.27,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.1,
                      backgroundColor: Colors.white.withOpacity(0),
                      foregroundColor: Colors.white.withOpacity(0),
                      backgroundImage:
                          const AssetImage('assets/images/Logo.jpeg'),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "$userName",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(5, 1, 5, 1)),
              backgroundColor: (_selectedIndex == 0
                  ? MaterialStateProperty.all(const Color.fromARGB(88, 0, 0, 0))
                  : MaterialStateProperty.all(
                      const Color.fromARGB(0, 0, 0, 0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 44)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            child: const ListTile(
              leading: Icon(
                Ionicons.bed,
                color: Colors.black,
              ),
              title: Text(
                'Rooms',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            onPressed: () async {
              _navigatorBar(0);
            },
          ),
          ExpansionTile(
            title: const Text(
              'Tenants',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            leading: const Icon(
              Ionicons.person,
              color: Colors.black,
            ),
            collapsedIconColor: Colors.black,
            iconColor: Colors.black,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                  backgroundColor: (_selectedIndex == 1
                      ? MaterialStateProperty.all(
                          const Color.fromARGB(88, 0, 0, 0))
                      : MaterialStateProperty.all(
                          const Color.fromARGB(0, 0, 0, 0))),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 44)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: const ListTile(
                  title: Text(
                    'Pending',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                onPressed: () async {
                  _navigatorBar(1);
                },
              ),
              const SizedBox(
                height: 7,
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                  backgroundColor: (_selectedIndex == 2
                      ? MaterialStateProperty.all(
                          const Color.fromARGB(88, 0, 0, 0))
                      : MaterialStateProperty.all(
                          const Color.fromARGB(0, 0, 0, 0))),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 44)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: const ListTile(
                  title: Text(
                    'Approved',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                onPressed: () async {
                  _navigatorBar(2);
                },
              ),
              const SizedBox(
                height: 7,
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(5, 1, 5, 1)),
                  backgroundColor: (_selectedIndex == 3
                      ? MaterialStateProperty.all(
                          const Color.fromARGB(88, 0, 0, 0))
                      : MaterialStateProperty.all(
                          const Color.fromARGB(0, 0, 0, 0))),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 44)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: const ListTile(
                  title: Text(
                    'Rejected',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                onPressed: () async {
                  _navigatorBar(3);
                },
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(5, 1, 5, 1)),
              backgroundColor: (_selectedIndex == 4
                  ? MaterialStateProperty.all(const Color.fromARGB(88, 0, 0, 0))
                  : MaterialStateProperty.all(
                      const Color.fromARGB(0, 0, 0, 0))),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 44)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            child: const ListTile(
              leading: Icon(
                Ionicons.settings,
                color: Colors.black,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            onPressed: () async {
              _navigatorBar(4);
            },
          ),
          SizedBox(
            height: ((MediaQuery.of(context).size.height * 0.4145454) + 300)/2,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                minVerticalPadding: MediaQuery.of(context).size.height * 0.025,
                tileColor: Color(navBarColor),
                hoverColor: Colors.blue,
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  logout(context);
                },
              ),
            ),
          ),
        ]),
      ),
      body: _pages[_selectedIndex],
      backgroundColor: const Color(0xFFafeeee),
      // ignore: prefer_const_literals_to_create_immutables
    );
  }
}