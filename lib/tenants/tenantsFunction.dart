import 'tenantsModel.dart';
import 'package:http/http.dart' as http;
import '../auth/connection.dart';
import '../bedroom/roompage.dart';
import 'package:hotel/pages/signin.dart';

Future<List<Tenants>> pendingTenants() async {
  print("CHECK");
  String urlConn = "${url}tenants/pending.php";
  var response = await http.post(
    Uri.parse(urlConn),
    body: {
      "username": userNameReal,
    },
  );
  print(tenantsFromJson(response.body));
  return tenantsFromJson(response.body);
}

Future<List<Tenants>> approvedTenants() async {
  String urlConn = "${url}tenants/approved.php";
  var response = await http.post(
    Uri.parse(urlConn),
    body: {
      "username": userNameReal,
    },
  );
  return tenantsFromJson(response.body);
}

Future<List<Tenants>> rejectedTenants() async {
  String urlConn = "${url}tenants/rejected.php";
  var response = await http.post(
    Uri.parse(urlConn),
    body: {
      "username": userNameReal,
    },
  );
  return tenantsFromJson(response.body);
}

Future<List<Tenants>> notificationGet() async {
  String urlConn = "${url}notification/notification.php";
  var response = await http.get(
    Uri.parse(urlConn),
  );
  print(response.body);
  return tenantsFromJson(response.body);
}

Future<List<Tenants>> tenantSingle() async {
  String urlConn = "${url}tenants/tenantsInformation.php";
  var response = await http.post(
    Uri.parse(urlConn),
    body: {"tenantId": room_tenant},
  );
  print(response.body);
  return tenantsFromJson(response.body);
}
