import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Services/Street/StreetPossationsDto_S.dart';
import 'package:MTApp/src/Services/Street/Street_S.dart';
import 'package:MTApp/src/UI/Map/Page/SearchPage.dart';
import 'package:MTApp/src/UI/Street/Page/StreetList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loding extends StatefulWidget {
  final int streetId;
  Loding({this.streetId});
  @override
  _LodingState createState() => _LodingState();
}

class _LodingState extends State<Loding> {
  StreetPossationsDto_S possation = new StreetPossationsDto_S();
  StreetPossationsDto streetPossation;

  Street_S str = new Street_S();
  AllStreetDto street;

  String time = "loading...";
  Future<void> setUpWorldTime() async {
    try {
      var streetPossation = await possation.getStreets(widget.streetId);
      var street = await str.getStreets(widget.streetId);
      print(" street data work");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapSearch(
              streetPossation: streetPossation,
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
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
