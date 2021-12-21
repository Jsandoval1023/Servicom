import 'package:flutter/material.dart';
import 'package:app/pantallaprincipal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/departamentos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Registro Datos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final Telephony telephony = Telephony.instance;
  final TextEditingController _documento = TextEditingController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _municipio = TextEditingController();
  final TextEditingController _apellido = TextEditingController();
  final TextEditingController _direccion = TextEditingController();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("municipios");

  final Firebase = FirebaseFirestore.instance;

  String selectedProvince = '';
  String selecteddepartamento = 'Seleccione Departamento';
  String selectedmunicipio = '';
  List<Map> datos = [];
  String departamento = "";
  String municipio = "";
  String razonsocial = "";
  String nombre = "";
  int documento = 0;
  String documento1 = "";
  String apellido = "";
  String direccion = "";
  String value = "vacio";
  String mensaje = "";
  String remitente = "";

  bool disabledropdow = true;
  List<DropdownMenuItem<String>> menuitems = [];
  final putumayo = {
    "1": "Puerto leguízamo",
    "2": "Colón",
    "3": "Mocoa",
    "4": "Orito",
    "5": "Puerto Asís",
    "6": "Puerto Caicedo",
    "7": "San Franciso",
    "8": "San Miguel",
    "9": "Santiago",
    "10": "Sibundoy",
    "11": "Valle del Guamuez",
    "12": "Villagarzón",
  };
  final nortedesantander = {
    "1": "Cúcuta",
    "2": "Ocaña",
    "3": "Villa del rosario",
    "4": "Los patios",
    "5": "Pamplona",
    "6": "Abrego",
    "7": "Tibú",
    "8": "El zulia",
    "9": "Sardinata",
    "10": "Toledo",
    "11": "Teorama",
    "12": "Chinácota",
    "13": "Convención",
    "14": "El carmen",
    "15": "La esperanza",
    "16": "Cáchira",
  };

  void poulateputumayo() {
    for (String key in putumayo.keys) {
      menuitems.add(DropdownMenuItem<String>(
        value: putumayo[key],
        child: Center(
          child: Text(putumayo[key].toString()),
        ),
      ));
    }
  }

  void poulatenorte() {
    for (String key in nortedesantander.keys) {
      menuitems.add(DropdownMenuItem<String>(
        value: nortedesantander[key],
        child: Center(
          child: Text(nortedesantander[key].toString()),
        ),
      ));
    }
  }

  void ValueChanged(_value) {
    if (_value == "Putumayo") {
      menuitems = [];
      selecteddepartamento = "Putumayo";
      selectedmunicipio = "Seleccione Municipio";
      poulateputumayo();
      remitente = "3137749393";
    } else if (_value == "Nortedesantander") {
      menuitems = [];
      selecteddepartamento = "Norte de santander";
      selectedmunicipio = "Seleccione Municipio";
      poulatenorte();
      remitente = "3174853049";
    } else {
      disabledropdow = false;
    }
    setState(() {
      value = _value;
      disabledropdow = false;
    });
  }

  void secondvaluechanged(_value) {
    setState(() {
      selectedmunicipio = _value;
    });
  }

  registrar() async {
    nombre = _nombre.text;
    apellido = _apellido.text;
    direccion = _direccion.text;
    documento1 = _documento.text;
    departamento = selecteddepartamento;
    municipio = selectedmunicipio;

    await Firebase.collection("registro").doc(documento1).set({
      "documento": documento1,
      "nombre": nombre,
      "apellido": apellido,
      "direccion": direccion,
      "municipio": municipio,
      "departamento": departamento
    });
    _file();
  }

  _file() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nombre = _nombre.text;
      apellido = _apellido.text;
      direccion = _direccion.text;
      documento1 = _documento.text;
      municipio = selectedmunicipio;

      prefs.setString("nombre", nombre);
      prefs.setString("apellido", apellido);
      prefs.setString("direccion", direccion);
      prefs.setString("documento", documento1);
      prefs.setString("municipio", municipio);
      prefs.setString("remitente", remitente);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<Null>(
            builder: (context) => pantallaprincipal(),
          ),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarpreferencias();
    getUsers();
  }

  void getUsers() async {
    QuerySnapshot registro1 = await collectionReference.get();
    if (registro1.docs.length != 0) {
      for (var doc in registro1.docs) {
        print(registro1.docs);
      }
    }
  }

  _cargarpreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nombre = prefs.getString("nombre") ?? 'vacio';
      if (nombre == value) {
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<Null>(
              builder: (context) => pantallaprincipal(),
            ),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: Text("registro"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/usuario.png',
                  width: 120,
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _documento,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Documento';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Numero Documento',
                        labelText: 'Numero Documento'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nombre,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese  Nombre';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nombre',
                        labelText: 'Nombre'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _apellido,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese  Apellido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Apellido',
                        labelText: 'Apellido'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _direccion,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese  Direccion';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Direccion',
                        labelText: 'Direccion'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    items: [
                      DropdownMenuItem<String>(
                        value: "Putumayo",
                        child: Center(
                          child: Text("putumayo"),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Nortedesantander",
                        child: Center(
                          child: Text("Norte de santander"),
                        ),
                      ),
                    ],
                    onChanged: (_value) => ValueChanged(_value),
                    hint: Text(selecteddepartamento),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    items: menuitems,
                    onChanged: disabledropdow
                        ? null
                        : (_value) => secondvaluechanged(_value),
                    hint: Text(selectedmunicipio),
                    disabledHint: Text("primero selecicione departamento"),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      registrar();
                    },
                    child: const Text('Enviar Datos')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
