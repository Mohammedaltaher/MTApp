import 'dart:convert';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class AllStreetDto_S {
  AllStreetDto_S() {
    var d = getStreets(); //d
  }
  Future<AllStreetDto> getStreets() async {
    try {
      print("hi");
      Response resp = await get(
          "http://192.168.43.234/mtApi/api/GetCurrentAllStreetStatus");

      print("h3");
      Map data = jsonDecode(resp.body);
      var street = AllStreetDto.fromJson(data);

      print(street.data.elementAt(0).streetName);

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
