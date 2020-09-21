import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:MTApp/src/Services/Street/Street_S.dart';
import 'package:MTApp/src/UI/Street/Page/StreetList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loding extends StatefulWidget {
  @override
  _LodingState createState() => _LodingState();
}

class _LodingState extends State<Loding> {
  Street_S st = new Street_S();
  StreetDto streetList;
  String time = "loading...";
  Future<void> setUpWorldTime() async {
    var data = await st.getStreets();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreetList(
            data: data,
          ),
        ));
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
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
