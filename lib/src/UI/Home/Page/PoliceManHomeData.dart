import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Services/Street/AllStreetDto_S.dart';
import 'package:MTApp/src/Services/Street/GetAllStreetDetails.dart';
import 'package:MTApp/src/Services/Street/GetCurrentAllStreetStatus.dart';
import 'package:MTApp/src/UI/Home/Page/HomePage.dart';
import 'package:MTApp/src/UI/Home/Page/PoliceManHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PoliceManHomeData extends StatefulWidget {
  @override
  _PoliceManHomeDataState createState() => _PoliceManHomeDataState();
}

class _PoliceManHomeDataState extends State<PoliceManHomeData> {
  GetCurrentAllStreetStatus st = new GetCurrentAllStreetStatus();
  GetAllStreetDetails streetDetailsS = new GetAllStreetDetails();
  AllStreetDto_S allStreetS = new AllStreetDto_S();

  StreetPossationsDto streetPoassition;
  AllStreetDto allstreetList;
  String time = "loading...";
  Future<void> setUpWorldTime() async {
    try {
      var streetPoassitionData = await st.getData();
      var allStreetdata = await allStreetS.getStreets();
      var allStreetDetailsdata = await streetDetailsS.getData();
      print(streetPoassitionData);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PoliceManHomePage(
                streetPoassition: streetPoassitionData,
                allStreetList: allStreetdata,
                allStreetDetailsdata: allStreetDetailsdata),
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
