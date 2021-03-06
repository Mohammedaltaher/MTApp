import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:MTApp/src/Services/Street/AllStreetDto_S.dart';
import 'package:MTApp/src/UI/Street/Page/StreetList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LodeStreetData extends StatefulWidget {
  @override
  _LodeStreetDataState createState() => _LodeStreetDataState();
}

class _LodeStreetDataState extends State<LodeStreetData> {
  AllStreetDto_S st = new AllStreetDto_S();
  AllStreetDto streetList;
  String time = "loading...";
  Future<void> setUpWorldTime() async {
    try {
      var data = await st.getStreets();
      print(data);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StreetList(
              data: data,
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
