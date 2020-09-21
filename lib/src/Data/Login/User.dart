import 'dart:convert';
import 'package:http/http.dart';

class User {
  User() {
    getData();
  }
  void getData() async {
    try {
      print("hi");
      Response resp = await get("http://192.168.8.185:8040/api/users");
      Map data = jsonDecode(resp.body);
      print(data["FullName"]);
      //  print(data);
      // String dateTime = data["datetime"];
      // String offset = (data["utc_offset"]);
      // DateTime time = DateTime.parse(dateTime);
      // isDayTime = time.hour > 6 && time.hour < 20 ? true : false;
      // time = time.add(Duration(hours: int.parse(offset.substring(1, 3))));
      // data1 = data.toString();
      // resp.body.toString();
    } catch (e) {
      print(e.toString());
    }
  }
}
