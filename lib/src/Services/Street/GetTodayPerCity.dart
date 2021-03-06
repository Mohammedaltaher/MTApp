import 'dart:convert';
import 'package:MTApp/src/Data/Street/StreetReportDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class GetTodayPerCity {
  GetTodayPerCity() {
    var d = getStreets(); //d
  }
  Future<StreetReportDto> getStreets() async {
    try {
      print("city");
      Response resp =
          await get("http://192.168.43.234/mtApi/api/GetTodayPerCity");

      print("Get Today Per City");
      Map data = jsonDecode(resp.body);
      var street = StreetReportDto.fromJson(data);

      print(street.data.elementAt(0).value);

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
