import 'dart:convert';

import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class Street_S {
  Street_S() {
    var d = getStreets();
  }
  Future<StreetDto> getStreets() async {
    //try {
    print("hi");
    Response resp =
        await get("http://192.168.8.185:8040/api/Search?streetName=s");

    print("h3");
    Map data = jsonDecode(resp.body);
    var street = StreetDto.fromJson(data);

    print(street.data.elementAt(0).streetName);

    return street;
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
