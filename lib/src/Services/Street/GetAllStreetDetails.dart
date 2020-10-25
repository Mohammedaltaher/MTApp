import 'dart:convert';
import 'package:MTApp/src/Data/Street/StreetDetailsDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Data/Street/StreetReportDto.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class GetAllStreetDetails {
  // ignore: missing_return
  Future<StreetsDetailsDto> getData() async {
    try {
      print("hi");
      Response resp =
          await get("http://192.168.43.234/mtApi/api/GetAllStreetDetails");

      print("h3");
      Map data = jsonDecode(resp.body);
      var street = StreetsDetailsDto.fromJson(data);

      print(street.data.elementAt(0).capacity);

      return street;
    } catch (e) {
      print(e.toString());
    }
  }
}
