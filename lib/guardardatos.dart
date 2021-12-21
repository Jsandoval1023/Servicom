import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/message_response.dart';

class alertas extends StatefulWidget {
  @override
  State<alertas> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<alertas> {
  final Telephony telephony = Telephony.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _valueSms = TextEditingController();
  final TextEditingController _valueSms1 = TextEditingController();
  String razonsocial = "";
  String nombre = "";
  String municipio = "";
  int documento = 0;
  String documento1 = "";
  String apellido = "";
  String direccion = "";
  String value = "vacio";
  int codigo = 0;
  String remitente = "";
  String m = "";

  Location location = new Location();
  late bool _ServiceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = false, _isGetLocation = false;

  @override
  void initState() {
    super.initState();
    _phoneController.text = ' ';
    _msgController.text = ' ';
    _valueSms.text = ' ';
    _valueSms1.text = ' ';
    _cargarpreferencias();
  }

  _cargarpreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      razonsocial = prefs.getString("razonsocial") ?? 'vacio';
      nombre = prefs.getString("nombre") ?? 'vacio';
      apellido = prefs.getString("apellido") ?? 'vacio';
      direccion = prefs.getString("direccion") ?? 'vacio';
      documento1 = prefs.getString("documento") ?? 'vacio';
      municipio = prefs.getString("municipio") ?? 'vacio';
      remitente = prefs.getString("remitente") ?? 'vacio';
    });
    posicion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fondo.png'), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () => _sendSMS("947"),
            child: Image.asset(
              'assets/images/1.png',
              width: 200,
              height: 200,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => _sendSMS("533"),
                child: Image.asset(
                  'assets/images/2.png',
                  width: 150,
                  height: 150,
                ),
              ),
              TextButton(
                onPressed: () => _sendSMS("557"),
                child: Image.asset(
                  'assets/images/3.png',
                  width: 150,
                  height: 150,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

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

  _sendSMS(value1) async {
    var codigo = value1;
    var latitu = _locationData.latitude;
    var longitud = _locationData.longitude;
    var mensaje1 = latitu.toString();
    var mensaje2 = longitud.toString();

    if (razonsocial == value) {
      _valueSms.text = "Cod:" +
          codigo +
          "\n" +
          "Nombre:" +
          nombre +
          "\n" +
          "Apellido:" +
          apellido +
          "\n" +
          "Cc:" +
          documento1 +
          "\n" +
          "Municipio:" +
          municipio +
          "\n" +
          "Dir:" +
          direccion +
          "\n" +
          "GPS:" +
          mensaje1 +
          ";" +
          mensaje2;

      telephony.sendSms(to: remitente, message: _valueSms.text);
      messageResponse(context, "Emergencia" + " ha sido enviada!");
    } else {
      _valueSms.text = "Cod:" +
          codigo +
          "\n" +
          "razon social:" +
          razonsocial +
          "\n" +
          "Municipio:" +
          municipio +
          "\n" +
          "Dir:" +
          direccion +
          "\n" +
          "GPS:" +
          mensaje1 +
          ";" +
          mensaje2;

      telephony.sendSms(to: remitente, message: _valueSms.text);
      messageResponse(context, "Emergencia" + " ha sido enviada!");
    }
  }
}
