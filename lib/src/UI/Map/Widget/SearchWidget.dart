import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchWidget {
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(-33.852, 151.211),
    zoom: 11.0,
  );

  CameraPosition _position = _kInitialPosition;
  bool _isMapCreated = false;
  bool _isMoving = false;
  bool _compassEnabled = true;
  bool _mapToolbarEnabled = true;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  MapType _mapType = MapType.normal;
  bool _rotateGesturesEnabled = true;
  bool _scrollGesturesEnabled = true;
  bool _tiltGesturesEnabled = true;
  bool _zoomControlsEnabled = false;
  bool _zoomGesturesEnabled = true;
  bool _indoorViewEnabled = true;
  bool _myLocationEnabled = true;
  bool _myTrafficEnabled = false;
  bool _myLocationButtonEnabled = true;
  GoogleMapController _controller;
  bool _nightMode = false;

  Widget compassToggler() {
    return FlatButton(
      child: Text('${_compassEnabled ? 'disable' : 'enable'} compass'),
      onPressed: () {
        // setState(() {
        //   _mapToolbarEnabled = !_mapToolbarEnabled;
        // });
      },
    );
  }

  // Widget _mapToolbarToggler() {
  //   return FlatButton(
  //     child: Text('${_mapToolbarEnabled ? 'disable' : 'enable'} map toolbar'),
  //     onPressed: () {
  //       setState(() {
  //         _mapToolbarEnabled = !_mapToolbarEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _latLngBoundsToggler() {
  //   return FlatButton(
  //     child: Text(
  //       _cameraTargetBounds.bounds == null
  //           ? 'bound camera target'
  //           : 'release camera target',
  //     ),
  //     onPressed: () {
  //       setState(() {
  //         _cameraTargetBounds = _cameraTargetBounds.bounds == null
  //             ? CameraTargetBounds(sydneyBounds)
  //             : CameraTargetBounds.unbounded;
  //       });
  //     },
  //   );
  // }

  // Widget _zoomBoundsToggler() {
  //   return FlatButton(
  //     child: Text(_minMaxZoomPreference.minZoom == null
  //         ? 'bound zoom'
  //         : 'release zoom'),
  //     onPressed: () {
  //       setState(() {
  //         _minMaxZoomPreference = _minMaxZoomPreference.minZoom == null
  //             ? const MinMaxZoomPreference(12.0, 16.0)
  //             : MinMaxZoomPreference.unbounded;
  //       });
  //     },
  //   );
  // }

  // Widget _mapTypeCycler() {
  //   final MapType nextType =
  //       MapType.values[(_mapType.index + 1) % MapType.values.length];
  //   return FlatButton(
  //     child: Text('change map type to $nextType'),
  //     onPressed: () {
  //       setState(() {
  //         _mapType = nextType;
  //       });
  //     },
  //   );
  // }

  // Widget _rotateToggler() {
  //   return FlatButton(
  //     child: Text('${_rotateGesturesEnabled ? 'disable' : 'enable'} rotate'),
  //     onPressed: () {
  //       setState(() {
  //         _rotateGesturesEnabled = !_rotateGesturesEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _scrollToggler() {
  //   return FlatButton(
  //     child: Text('${_scrollGesturesEnabled ? 'disable' : 'enable'} scroll'),
  //     onPressed: () {
  //       setState(() {
  //         _scrollGesturesEnabled = !_scrollGesturesEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _tiltToggler() {
  //   return FlatButton(
  //     child: Text('${_tiltGesturesEnabled ? 'disable' : 'enable'} tilt'),
  //     onPressed: () {
  //       setState(() {
  //         _tiltGesturesEnabled = !_tiltGesturesEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _zoomToggler() {
  //   return FlatButton(
  //     child: Text('${_zoomGesturesEnabled ? 'disable' : 'enable'} zoom'),
  //     onPressed: () {
  //       setState(() {
  //         _zoomGesturesEnabled = !_zoomGesturesEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _zoomControlsToggler() {
  //   return FlatButton(
  //     child:
  //         Text('${_zoomControlsEnabled ? 'disable' : 'enable'} zoom controls'),
  //     onPressed: () {
  //       setState(() {
  //         _zoomControlsEnabled = !_zoomControlsEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _indoorViewToggler() {
  //   return FlatButton(
  //     child: Text('${_indoorViewEnabled ? 'disable' : 'enable'} indoor'),
  //     onPressed: () {
  //       setState(() {
  //         _indoorViewEnabled = !_indoorViewEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _myLocationToggler() {
  //   return FlatButton(
  //     child: Text(
  //         '${_myLocationEnabled ? 'disable' : 'enable'} my location marker'),
  //     onPressed: () {
  //       setState(() {
  //         _myLocationEnabled = !_myLocationEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _myLocationButtonToggler() {
  //   return FlatButton(
  //     child: Text(
  //         '${_myLocationButtonEnabled ? 'disable' : 'enable'} my location button'),
  //     onPressed: () {
  //       setState(() {
  //         _myLocationButtonEnabled = !_myLocationButtonEnabled;
  //       });
  //     },
  //   );
  // }

  // Widget _myTrafficToggler() {
  //   return FlatButton(
  //     child: Text('${_myTrafficEnabled ? 'disable' : 'enable'} my traffic'),
  //     onPressed: () {
  //       setState(() {
  //         _myTrafficEnabled = !_myTrafficEnabled;
  //       });
  //     },
  //   );
  // }
  //   Widget _nightModeToggler() {
  //   if (!_isMapCreated) {
  //     return null;
  //   }
  //   return FlatButton(
  //     child: Text('${_nightMode ? 'disable' : 'enable'} night mode'),
  //     onPressed: () {
  //       if (_nightMode) {
  //         setState(() {
  //           _nightMode = false;
  //           _controller.setMapStyle(null);
  //         });
  //       } else {
  //         _getFileData('assets/night_mode.json').then(_setMapStyle);
  //       }
  //     },
  //   );
  // }
  // Future<String> _getFileData(String path) async {
  //   return await rootBundle.loadString(path);
  // }

  // void _setMapStyle(String mapStyle) {
  //   setState(() {
  //     _nightMode = true;
  //     _controller.setMapStyle(mapStyle);
  //   });
  // }
  // void _updateCameraPosition(CameraPosition position) {
  //   setState(() {
  //     _position = position;
  //   });
  // }

  // void onMapCreated(GoogleMapController controller) {
  //    setState(() {
  //     _controller = controller;
  //     _isMapCreated = true;
  //   });
  // }
}
