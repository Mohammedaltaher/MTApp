import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearch extends StatefulWidget {
  @override
  _MapSearchState createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;

  static const LatLng _center = const LatLng(15.564836, 32.529831);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> markers2 = Set();

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<void> upDateMakers() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/car.png', 100);
    setState(() {
      markers2.addAll([
        Marker(
            markerId: MarkerId('value'),
            position: LatLng(15.564836, 32.529831),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
        Marker(
            markerId: MarkerId('value2'),
            position: LatLng(14.564836, 32.529880),
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
          markers: markers2,
        ),
      ),
    );
  }
}
