import 'dart:async';
import 'dart:typed_data';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Data/Street/StreetReportDto.dart';
import 'package:MTApp/src/Services/Map/Street_S.dart';
import 'package:MTApp/src/Services/Street/StreetPossationsDto_S.dart';
import 'package:MTApp/src/UI/Home/Page/PoliceManHomeData.dart';
import 'package:MTApp/src/UI/Home/Page/PoliceManHomePage.dart';
import 'package:MTApp/src/UI/Login/Widget/NavDrawerWidget.dart';
import 'package:MTApp/src/UI/Map/Page/Loding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StreetDetailsInfo extends StatefulWidget {
  final StreetReportDto HourReport;
  final StreetReportDto WeekReport;
  final StreetReportDto YearReport;
  final AllStreetDto street;
  StreetDetailsInfo(
      {this.street, this.HourReport, this.WeekReport, this.YearReport});
  @override
  _StreetDetailsInfoState createState() => _StreetDetailsInfoState();
}

class _StreetDetailsInfoState extends State<StreetDetailsInfo> {
  Completer<GoogleMapController> _controller = Completer();

  // StreetPossationsDto_S st = new StreetPossationsDto_S();
  StreetReportDto hourReport;
  StreetReportDto weekReport;
  StreetReportDto yearReport;
  AllStreetDto street;

  void updateDate() async {
    setState(() {
      hourReport = widget.HourReport;
      weekReport = widget.WeekReport;
      yearReport = widget.YearReport;
      street = widget.street;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDate();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => PoliceManHomeData()));
  }

  Map_S map = new Map_S();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        title: 'Monitroing Traffic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: NavDrawerWidget(),
            appBar: AppBar(
              title: Text('MT Traffic Man'),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xfff7892b),
              bottom: TabBar(
                indicatorColor: Colors.white,
                mouseCursor: MouseCursor.uncontrolled,
                tabs: [
                  Tab(text: 'Hours', icon: Icon(Icons.hourglass_full)),
                  Tab(text: 'Days', icon: Icon(Icons.calendar_view_day)),
                  Tab(text: 'Months', icon: Icon(Icons.access_time)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(child: _getStreetHourReport()),
                Center(child: _getStreetWeekReport()),
                Center(child: _getStreetYearReport()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getStreetHourReport() {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      DataTable(
        columns: [
          DataColumn(
              label: Text('Hour',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text(' Cars',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Traffic %',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ],
        rows: hourReport.data
            .map(
              ((element) => DataRow(
                    onSelectChanged: (bool selected) {
                      if (selected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loding(
                                streetId: element.streetId,
                              ),
                            ));
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(element.value.toString() + ":00",
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.carsCount.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.trafficJam.toStringAsFixed(2) + "%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: getTrafficColor(
                                (element.trafficJam),
                              )))),
                    ],
                  )),
            )
            .toList(),
      ),
    ]);
  }

  Widget _getStreetWeekReport() {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      DataTable(
        columns: [
          DataColumn(
              label: Text('Day',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text(' Cars',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Traffic %',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ],
        rows: weekReport.data
            .map(
              ((element) => DataRow(
                    onSelectChanged: (bool selected) {
                      if (selected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loding(
                                streetId: element.streetId,
                              ),
                            ));
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(element.value.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.carsCount.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.trafficJam.toStringAsFixed(2) + "%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: getTrafficColor(
                                (element.trafficJam),
                              )))),
                    ],
                  )),
            )
            .toList(),
      ),
    ]);
  }

  Widget _getStreetYearReport() {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      DataTable(
        columns: [
          DataColumn(
              label: Text('Month',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Cars',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Traffic %',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ],
        rows: yearReport.data
            .map(
              ((element) => DataRow(
                    onSelectChanged: (bool selected) {
                      if (selected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loding(
                                streetId: element.streetId,
                              ),
                            ));
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(element.value.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.carsCount.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.trafficJam.toStringAsFixed(2) + "%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: getTrafficColor(
                                (element.trafficJam),
                              )))),
                    ],
                  )),
            )
            .toList(),
      ),
    ]);
  }

  Color getTrafficColor(double trafficJam) {
    if (trafficJam > 90) {
      return Colors.red;
    } else if (trafficJam > 70) {
      return Colors.orange[600];
    } else if (trafficJam > 60) {
      return Colors.yellow[600];
    } else if (trafficJam > 20) {
      return Colors.green[600];
    }
    return Colors.blue;
  }
}
