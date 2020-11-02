import 'dart:async';
import 'dart:typed_data';
import 'package:MTApp/src/Data/Login/User.dart';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Services/Map/Street_S.dart';
import 'package:MTApp/src/UI/Home/Page/LodeHomeData.dart';
import 'package:MTApp/src/UI/Login/Page/loginPage.dart';
import 'package:MTApp/src/UI/Login/Widget/NavDrawerWidget.dart';
import 'package:MTApp/src/UI/Login/Widget/WelcomeWidget.dart';
import 'package:MTApp/src/UI/Map/Page/Loding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final StreetPossationsDto streetPoassition;
  final AllStreetDto allStreetList;
  HomePage({this.streetPoassition, this.allStreetList});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = new User();
  StreetPossationsDto streetPoassition;
  AllStreetDto allStreetList;
  Completer<GoogleMapController> _controller = Completer();
  var item;
  void updateDate() async {
    setState(() {
      streetPoassition = widget.streetPoassition;
      allStreetList = widget.allStreetList;
    });
  }

  Timer timer;
  @override
  void initState() {
    super.initState();
    updateDate();
    upDateMakers();
    // timer = Timer.periodic(
    //     Duration(seconds: 30), (Timer t) => checkForNewSharedLists());
  }

  // checkForNewSharedLists() {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => LodeHomeData()));
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

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

  Future<bool> _onBackPressed() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
            length: 2,
            child: Scaffold(
              drawer: NavDrawerWidget(),
              appBar: AppBar(
                title: Text('MT Citzen'),
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xfff7892b),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  mouseCursor: MouseCursor.uncontrolled,
                  tabs: [
                    Tab(text: 'Streets', icon: Icon(Icons.pin_drop)),
                    Tab(text: 'Map', icon: Icon(Icons.map)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(child: _getStreetList()),
                  Center(child: _getMap()),
                ],
              ),
            ),
          ),
        ));
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
}
