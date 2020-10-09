import 'dart:async';
import 'dart:typed_data';
import 'package:MTApp/src/Services/Map/Street_S.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearch extends StatefulWidget {
  @override
  _MapSearchState createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(15.564836, 32.529831);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> markers = Set();
  Map_S map = new Map_S();

  Future<void> upDateMakers() async {
    final Uint8List markerIcon =
        await map.getBytesFromAsset('assets/images/car.png', 100);
    setState(() {
      markers.addAll([
        Marker(
            markerId: MarkerId('value'),
            position: LatLng(15.564836, 32.529831),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
        Marker(
            markerId: MarkerId('value2'),
            position: LatLng(14.564836, 32.529880),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
        Marker(
            markerId: MarkerId('value3'),
            position: LatLng(12.56736, 32.529880),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
        Marker(
            markerId: MarkerId('value4'),
            position: LatLng(11.564936, 32.529880),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
        Marker(
            markerId: MarkerId('value5'),
            position: LatLng(4.564736, 32.529880),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
        Marker(
            markerId: MarkerId('value6'),
            position: LatLng(24.564836, 32.529880),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
      ]);
    });
  }

  @override
  void initState() {
    super.initState();
    upDateMakers();
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
            target: _center,
            zoom: 15.0,
          ),
          mapType: MapType.normal,
          markers: markers,
        ),
      ),
    );
  }
}
