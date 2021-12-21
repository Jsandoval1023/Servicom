import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(alertas3());

class alertas3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Location location = new Location();
  late bool _ServiceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = false, _isGetLocation = false;

  late GoogleMapController _controller;

  posicion() async {
    _ServiceEnabled = await location.serviceEnabled();
    if (!_ServiceEnabled) {
      _ServiceEnabled = await location.requestService();
      if (_ServiceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }
    _locationData = await location.getLocation();
    setState(() {
      _isGetLocation = true;
    });
    _locationData = await location.getLocation();
    setState(() {
      _isGetLocation = true;
    });
  }

  static final Marker _kgoogle = Marker(
    markerId: MarkerId('Google'),
    infoWindow: InfoWindow(title: 'Mi Ubicación'),
    icon: BitmapDescriptor.defaultMarker,
  );
  @override
  Widget build(BuildContext context) {
    posicion();
    var latitu = _locationData.latitude;
    var longitud = _locationData.longitude;
    var mensaje1 = latitu.toString();
    var mensaje2 = longitud.toString();
    var n = double.parse(mensaje1);
    var n1 = double.parse(mensaje2);

    LatLng latLng = LatLng(n, n1);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 17);

    return new Scaffold(
      body: GoogleMap(
        markers: {_kgoogle},
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (controlador) {
          _controller = controlador;
        },
        initialCameraPosition: cameraPosition,
        mapType: MapType.satellite,
      ),
    );
  }
}
