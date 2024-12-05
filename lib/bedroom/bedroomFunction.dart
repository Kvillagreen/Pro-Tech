import 'package:hotel/pages/signin.dart';
import 'package:http/http.dart' as http;
import '../auth/connection.dart';
import 'bedroomModel.dart';

Future<List<room>> roomCheck() async {
  print("CHECK");
  String urlConn = "${url}rooms/checkRoom.php";
  var response = await http.post(
    Uri.parse(urlConn),
    body: {
      "username": userNameReal,
    },
  );
  print(roomFromJson(response.body));
  return roomFromJson(response.body);
}
