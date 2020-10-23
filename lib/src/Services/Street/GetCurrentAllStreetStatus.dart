import 'dart:convert';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Data/Street/StreetReportDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class GetCurrentAllStreetStatus {
  // ignore: missing_return
  Future<StreetPossationsDto> getData() async {
    try {
      print("hi");
      Response resp =
          await get("http://192.168.43.234/mtApi/api/GetAllStreetPosstions");

      print("h3");
      Map data = jsonDecode(resp.body);
      var street = StreetPossationsDto.fromJson(data);

      print(street.data.elementAt(0).carsCount);

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
