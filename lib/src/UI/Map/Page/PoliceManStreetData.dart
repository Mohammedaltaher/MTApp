import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetReportDto.dart';
import 'package:MTApp/src/Services/Street/GetTodayPerHour.dart';
import 'package:MTApp/src/Services/Street/GetTodayPerWeek.dart';
import 'package:MTApp/src/Services/Street/GetTodayPerYear.dart';
import 'package:MTApp/src/Services/Street/StreetPossationsDto_S.dart';
import 'package:MTApp/src/Services/Street/Street_S.dart';
import 'package:MTApp/src/UI/Map/Page/SearchPage.dart';
import 'package:MTApp/src/UI/Map/Page/StreetDetailsInfo.dart';
import 'package:MTApp/src/UI/Street/Page/StreetList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PoliceManStreetData extends StatefulWidget {
  final int streetId;
  PoliceManStreetData({this.streetId});
  @override
  _PoliceManStreetDataState createState() => _PoliceManStreetDataState();
}

class _PoliceManStreetDataState extends State<PoliceManStreetData> {
  GetTodayPerHour todayHourS = new GetTodayPerHour();
  GetTodayPerWeek todayWeekS = new GetTodayPerWeek();
  GetTodayPerYear todayYearS = new GetTodayPerYear();
  StreetReportDto report;

  Street_S str = new Street_S();
  AllStreetDto street;

  String time = "loading...";
  Future<void> setUpWorldTime() async {
    try {
      var hourReport = await todayHourS.getData(widget.streetId);
      var WeekReport = await todayWeekS.getData(widget.streetId);
      var YearReport = await todayYearS.getData(widget.streetId);
      var street = await str.getStreets(widget.streetId);
      print(" street data work");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StreetDetailsInfo(
              HourReport: hourReport,
              WeekReport: WeekReport,
              YearReport: YearReport,
              street: street,
            ),
          ));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[400],
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
