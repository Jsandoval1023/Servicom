import 'package:flutter/material.dart';
import 'package:app/alertas.dart';
import 'package:app/delitos.dart';
import 'package:app/guardardatos.dart';

void main() {
  runApp(const pantallaprincipal());
}

class pantallaprincipal extends StatelessWidget {
  const pantallaprincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Mensaje de Alerta'),
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
  bool isBackButtonActivated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Emergencias", icon: Icon(Icons.announcement_outlined)),
              Tab(text: "Delitos", icon: Icon(Icons.admin_panel_settings)),
              Tab(text: "Maps", icon: Icon(Icons.add_location_rounded)),
            ],
          ),
          title: Row(
            children: [
              Hero(
                  tag: "logo",
                  child: Icon(
                    Icons.security,
                    size: 20,
                  )),
              SizedBox(
                width: 10,
              ),
              Text('Servicom')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            alertas(),
            Delitos(),
            alertas3(),
          ],
        ),
      ),
    );
  }
}
