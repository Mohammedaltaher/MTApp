import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Services/Street/AllStreetDto_S.dart';
import 'package:MTApp/src/Services/Street/GetCurrentAllStreetStatus.dart';
import 'package:MTApp/src/Services/Street/GetTodayPerCity.dart';
import 'package:MTApp/src/UI/Home/Page/HomePage.dart';
import 'package:MTApp/src/UI/Home/Page/IAHomePage.dart';
import 'package:MTApp/src/UI/Home/Page/PoliceManHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IAHomeData extends StatefulWidget {
  @override
  _IAHomeDataState createState() => _IAHomeDataState();
}

class _IAHomeDataState extends State<IAHomeData> {
  GetCurrentAllStreetStatus st = new GetCurrentAllStreetStatus();
  GetTodayPerCity cityReportS = new GetTodayPerCity();
  AllStreetDto_S allStreetS = new AllStreetDto_S();

  StreetPossationsDto streetPoassition;
  AllStreetDto allstreetList;
  String time = "loading...";
  Future<void> setUpWorldTime() async {
    try {
      var streetPoassitionData = await st.getData();
      var allStreetdata = await allStreetS.getStreets();
      var cityReport = await cityReportS.getStreets();
      print(streetPoassitionData);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IAHomePage(
                streetPoassition: streetPoassitionData,
                allStreetList: allStreetdata,
                cityReport: cityReport),
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
