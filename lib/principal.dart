import 'package:app/pedirdatos.dart';
import 'package:app/pedirdatosjur.dart';
import 'package:app/pantallaprincipal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class alertas23 extends StatefulWidget {
  @override
  State<alertas23> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<alertas23> {
  final _formKey = GlobalKey<FormState>();
  int codigo = 0;
  String nombre = "";
  String value = "vacio";
  @override
  void initState() {
    super.initState();
    _cargarpreferencias();
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

  _send(value1) async {
    var codigo = value1;
    if (codigo == "1") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<Null>(
            builder: (context) => MyApp1(),
          ),
          (Route<dynamic> route) => false);
    } else if (codigo == "2") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<Null>(
            builder: (context) => MyApp1023(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.indigo),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () => _send("1"),
            child: Image.asset(
              'assets/images/natural.png',
              width: 200,
              height: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Persona Natural",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white.withOpacity(0.50),
                decoration: TextDecoration.underline,
                decorationColor: Colors.indigo.withOpacity(0.15),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => _send("2"),
                child: Image.asset(
                  'assets/images/juridica.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Persona Juridica",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white.withOpacity(0.50),
                decoration: TextDecoration.underline,
                decorationColor: Colors.indigo.withOpacity(0.15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
