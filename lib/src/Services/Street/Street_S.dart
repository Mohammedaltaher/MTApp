import 'dart:convert';

import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class Street_S {
  Street_S() {
    //var d = getStreets(); //d
  }
  Future<AllStreetDto> getStreets(int streetId) async {
    try {
      print("hi");
      Response resp = await get(
          "http://192.168.43.234/mtApi/api/GetCurrentStreet?StreetId=" +
              streetId.toString());

      print("h3");
      Map data = jsonDecode(resp.body);
      var street = AllStreetDto.fromJson(data);

      print(street.data.elementAt(0).trafficJam.toString());

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
