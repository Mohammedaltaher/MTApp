import 'dart:async';
import 'dart:typed_data';
import 'package:MTApp/src/Data/Street/AllStreetDto.dart';
import 'package:MTApp/src/Data/Street/StreetPossationsDto.dart';
import 'package:MTApp/src/Services/Map/Street_S.dart';
import 'package:MTApp/src/Services/Street/StreetPossationsDto_S.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearch extends StatefulWidget {
  final StreetPossationsDto streetPossation;
  final AllStreetDto street;
  MapSearch({this.streetPossation, this.street});
  @override
  _MapSearchState createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  Completer<GoogleMapController> _controller = Completer();

  // StreetPossationsDto_S st = new StreetPossationsDto_S();
  StreetPossationsDto streetPoassition;
  AllStreetDto street;

  void updateDate() async {
    setState(() {
      streetPoassition = widget.streetPossation;
      street = widget.street;
    });
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

  Set<Marker> markers = Set();
  Map_S map = new Map_S();

  Future<void> upDateMakers() async {
    final Uint8List markerIcon =
        await map.getBytesFromAsset('assets/images/pin.png', 100);
    setState(() {
      var currentGoCars = street.data.elementAt(0).carrentCars;
      var currentBackCars = street.data.elementAt(1).carrentCars;

      for (var i = 0; i < currentGoCars + currentBackCars; i++) {
        if (streetPoassition.data.length > i)
          markers.add(Marker(
              markerId: MarkerId(
                  streetPoassition.data.elementAt(i).name + "-" + i.toString()),
              position: LatLng(streetPoassition.data.elementAt(i).latitude,
                  streetPoassition.data.elementAt(i).longitude),
              icon: BitmapDescriptor.fromBytes(markerIcon)));
      }
      // for (var i = 0; i < currentBackCars; i++) {
      //   if (streetPoassition.data.length > i)
      //     markers.add(Marker(
      //         markerId: MarkerId(
      //             streetPoassition.data.elementAt(i).name + "-" + i.toString()),
      //         position: LatLng(streetPoassition.data.elementAt(i).latitude,
      //             streetPoassition.data.elementAt(i).longitude + 0.000167),
      //         icon: BitmapDescriptor.fromBytes(markerIcon)));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(streetPoassition.data.elementAt(0).latitude,
                streetPoassition.data.elementAt(0).longitude),
            zoom: 12.0,
          ),
          mapType: MapType.normal,
          markers: markers,
        ),
      ),
    );
  }
}
