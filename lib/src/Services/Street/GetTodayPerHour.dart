import 'dart:convert';
import 'package:MTApp/src/Data/Street/StreetReportDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class GetTodayPerHour {
  Future<StreetReportDto> getData(int StreetId) async {
    try {
      print("hi");
      Response resp = await get(
          "http://192.168.43.234/mtApi/api/GetTodayPerHour?StreetId=1");

      print("h3");
      Map data = jsonDecode(resp.body);
      var street = StreetReportDto.fromJson(data);

      print(street.data.elementAt(0).streetId);

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
