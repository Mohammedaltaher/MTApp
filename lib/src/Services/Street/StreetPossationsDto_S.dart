import 'dart:convert';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class StreetPossationsDto_S {
  StreetPossationsDto_S() {
    //var d = getStreets(); //d
  }
  Future<StreetPossationsDto> getStreets(int steetId) async {
    try {
      print("hi Street Posstions");
      Response resp = await get(
          "http://192.168.43.234/mtApi/api/GetStreetPosstions?StreetId=" +
              steetId.toString());

      print("h Street Posstions");
      Map data = jsonDecode(resp.body);
      var street = StreetPossationsDto.fromJson(data);

      print(street.data.elementAt(0).streetName);

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
