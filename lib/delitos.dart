import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/message_response.dart';

class Delitos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Delitos_();
  }
}

class Delitos_ extends State<Delitos> {
  final Telephony telephony = Telephony.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _valueSms = TextEditingController();
  final TextEditingController _valueSms1 = TextEditingController();
  String municipio = "";
  String remitente = "";
  String nombre = "";
  int documento = 0;
  String documento1 = "";
  String apellido = "";
  String direccion = "";
  String value = "vacio";
  String codigo1 = "";
  int codigo = 0;
  String razonsocial = "";

  Location location = new Location();
  late bool _ServiceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  late bool _isListenLocation = false, _isGetLocation = false;

  Map<int, dynamic> listaDelitos = {
    0: ["HOMICIDIOS ", Icon(Icons.safety_divider)],
    1: ["SECUESTRO", Icon(Icons.settings_accessibility_sharp)],
    2: ["HURTO ", Icon(Icons.sports_kabaddi)],
    3: ["DELITOS SEXUALES", Icon(Icons.wc)],
    4: ["HERIDO (A)", Icon(Icons.sanitizer_rounded)],
    5: ["DISPAROS", Icon(Icons.scatter_plot)],
    6: ["VEHICULO HURTADO ", Icon(Icons.commute_outlined)],
    7: ["VEHICULO ABANDONADO", const Icon(Icons.car_rental)],
    8: [
      "PERSONA TRATANTO DE ENTRAR A UNA VIVIENDA ",
      Icon(Icons.cabin_outlined)
    ],
    9: ["PERSONA SOSPECHOSAS", Icon(Icons.person)],
    10: ["SUICIDIO ", Icon(Icons.nature_people_sharp)],
    11: [
      "PERSONA PIDIENDO AUXILIO ",
      Icon(Icons.settings_accessibility_rounded)
    ],
    12: ["CONSUMO DE ESTUPEFACIENTES ", Icon(Icons.smoking_rooms_outlined)],
    13: ["INUNDACIONES ", Icon(Icons.pool_outlined)],
    14: ["EXPLOSION", Icon(Icons.wb_iridescent_outlined)],
    15: ["INCENDIO ", Icon(Icons.local_fire_department)],
    16: [
      " ALTERACION TRANQUILIDAD ",
      Icon(Icons.connect_without_contact_sharp)
    ],
    17: ["RIÑA  ", Icon(Icons.personal_injury_outlined)],
    18: ["PERSONA TENDIDA EN LA VIA", Icon(Icons.airline_seat_flat_rounded)],
    19: ["MALTRATO ANIMAL ", Icon(Icons.pets_outlined)],
    20: ["ACCIDENTE DE TRANSITO ", Icon(Icons.car_repair)],
    21: ["MUERTE NATURAL", Icon(Icons.hotel_outlined)],
    22: ["DELITOS AMBIENTALES", Icon(Icons.spa_rounded)],
    23: ["EXTORSION", Icon(Icons.soap_sharp)],
    24: ["MENOR EN ESTABLECIMIENTOS PUBLICOS ", Icon(Icons.tag_faces)],
    25: ["PORTE ILEGAL DE ARMAS", Icon(Icons.sports_handball_sharp)],
    26: ["PERSONA DESAPARECIDA", Icon(Icons.support_agent)]
  };
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
      municipio = prefs.getString("municipio") ?? 'vacio';
      documento1 = prefs.getString("documento") ?? 'vacio';
      municipio = prefs.getString("municipio") ?? 'vacio';
      remitente = prefs.getString("remitente") ?? 'vacio';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView(
        children: List.generate(listaDelitos.length, (index) {
          //FUNCION QUE CONSTRUYE LAS OPCIONES REGISTRADAS EN EL DICCIONARIO
          return Padding(
              padding: EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  )),
                ),
                child: ListTile(
                  leading: listaDelitos.values.toList()[index][1],
                  title: Text(listaDelitos.values.toList()[index][0]),
                  onTap: () => _sendSMS(listaDelitos.keys.toList()[index]),
                ),
              ));
        }),
      ),
    ));
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
    posicion();
    var codigo = value1.toString();
    var latitu = _locationData.latitude;
    var longitud = _locationData.longitude;
    var mensaje1 = latitu.toString();
    var mensaje2 = longitud.toString();

    switch (value1) {
      case 0:
        codigo1 = "901";
        break;

      case 1:
        codigo1 = "902";
        break;
      case 2:
        codigo1 = "904";
        break;
      case 3:
        codigo1 = "906";
        break;
      case 4:
        codigo1 = "910";
        break;
      case 5:
        codigo1 = "911";
        break;
      case 6:
        codigo1 = "913";
        break;
      case 7:
        codigo1 = "914";
        break;
      case 8:
        codigo1 = "915";
        break;
      case 9:
        codigo1 = "916";
        break;
      case 10:
        codigo1 = "917";
        break;
      case 11:
        codigo1 = "919";
        break;
      case 12:
        codigo1 = "922";
        break;
      case 13:
        codigo1 = "928";
        break;
      case 14:
        codigo1 = "929";
        break;
      case 15:
        codigo1 = "931";
        break;
      case 16:
        codigo1 = "932";
        break;
      case 17:
        codigo1 = "934";
        break;
      case 18:
        codigo1 = "936";
        break;
      case 19:
        codigo1 = "938";
        break;
      case 20:
        codigo1 = "942";
        break;
      case 21:
        codigo1 = "953";
        break;
      case 22:
        codigo1 = "958";
        break;
      case 23:
        codigo1 = "963";
        break;
      case 24:
        codigo1 = "967";
        break;
      case 25:
        codigo1 = "969";
        break;
      case 26:
        codigo1 = "976";
        break;
    }

    if (razonsocial == value) {
      _valueSms.text = "Cod:" +
          codigo1 +
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
          codigo1 +
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
