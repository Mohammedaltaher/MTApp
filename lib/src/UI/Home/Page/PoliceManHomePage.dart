import 'dart:async';
import 'dart:typed_data';
import 'package:MTApp/src/Data/Login/User.dart';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetDetailsDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Services/Map/Street_S.dart';
import 'package:MTApp/src/UI/Login/Page/loginPage.dart';
import 'package:MTApp/src/UI/Login/Widget/NavDrawerWidget.dart';
import 'package:MTApp/src/UI/Login/Widget/WelcomeWidget.dart';
import 'package:MTApp/src/UI/Map/Page/Loding.dart';
import 'package:MTApp/src/UI/Map/Page/PoliceManStreetData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceManHomePage extends StatefulWidget {
  final StreetPossationsDto streetPoassition;
  final StreetsDetailsDto allStreetDetailsdata;
  final AllStreetDto allStreetList;
  PoliceManHomePage(
      {this.streetPoassition, this.allStreetList, this.allStreetDetailsdata});

  @override
  _PoliceManHomePageState createState() => _PoliceManHomePageState();
}

class _PoliceManHomePageState extends State<PoliceManHomePage> {
  User user = new User();
  StreetPossationsDto streetPoassition;
  AllStreetDto allStreetList;
  StreetsDetailsDto allStreetDetailList;
  Completer<GoogleMapController> _controller = Completer();
  var item;
  void updateDate() async {
    setState(() {
      streetPoassition = widget.streetPoassition;
      allStreetList = widget.allStreetList;
      allStreetDetailList = widget.allStreetDetailsdata;
    });
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    updateDate();
    upDateMakers();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Map_S map = new Map_S();
  WelcomeWidget w = new WelcomeWidget();
  Set<Marker> markers = Set();
  Future<void> upDateMakers() async {
    final Uint8List markerIcon =
        await map.getBytesFromAsset('assets/images/pin.png', 100);
    setState(() {
      var currentCars = streetPoassition.data.elementAt(0).carsCount;

      for (var i = 0; i < currentCars; i++) {
        if (streetPoassition.data.length > i)
          markers.add(Marker(
              markerId: MarkerId(
                  streetPoassition.data.elementAt(i).name + "-" + i.toString()),
              position: LatLng(streetPoassition.data.elementAt(i).latitude,
                  streetPoassition.data.elementAt(i).longitude),
              icon: BitmapDescriptor.fromBytes(markerIcon)));
      }
    });
  }

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
                  Tab(text: 'Streets', icon: Icon(Icons.pin_drop)),
                  Tab(text: 'Map', icon: Icon(Icons.map)),
                  Tab(text: 'Street Details', icon: Icon(Icons.map)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(child: _getStreetList()),
                Center(child: _getMap()),
                Center(child: _getStreetDetials()),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _getMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(streetPoassition.data.elementAt(0).latitude,
            streetPoassition.data.elementAt(0).longitude),
        zoom: 12.0,
      ),
      mapType: MapType.normal,
      markers: markers,
    );
  }

  Widget _getStreetList() {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      DataTable(
        columns: [
          DataColumn(
              label: Text('Name',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text(' From',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('To',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Traffic %',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ],
        rows: allStreetList.data
            .map(
              ((element) => DataRow(
                    onSelectChanged: (bool selected) {
                      if (selected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loding(
                                streetId: element.streetID,
                              ),
                            ));
                        print(element.carrentCars.toString());
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(element.streetName.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.from.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.to.toString(),
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

  Widget _getStreetDetials() {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        '',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      DataTable(
        columns: [
          DataColumn(
              label: Text('Name',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text(' City',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Capacity',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ],
        rows: allStreetDetailList.data
            .map(
              ((element) => DataRow(
                    onSelectChanged: (bool selected) {
                      if (selected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PoliceManStreetData(
                                streetId: element.id,
                              ),
                            ));
                        print(element.cityName.toString());
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(element.name.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.cityName.toString(),
                          style: TextStyle(fontSize: 10))),
                      DataCell(Text(element.capacity.toString(),
                          style: TextStyle(fontSize: 10))),
                    ],
                  )),
            )
            .toList(),
      ),
    ]);
  }
}
