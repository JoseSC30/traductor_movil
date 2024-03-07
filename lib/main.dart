import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Traductor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String palabra = '';
  String idioma = '';
  String respuestaDelApi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  palabra = value;
                });
              },
              decoration:
                  InputDecoration(labelText: 'Ingresar palabra a traducir'),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  idioma = value;
                });
              },
              decoration: InputDecoration(labelText: 'Idioma a traducir'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                enviarPalabra(palabra, idioma);
              },
              child: Text('Enviar'),
            ),
            SizedBox(height: 20),
            Text(
              'Traduccion: $respuestaDelApi', // Muestra la respuesta aquí
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> enviarPalabra(String palabra, String idioma) async {
    String mensaje = '$palabra, $idioma';

    const url = 'http://10.0.2.2:4000/consultas';
    final headers = {'Content-Type': 'application/json'};
    final body = {'mensaje': mensaje};

    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final respuesta = response.body;
      setState(() {
        respuestaDelApi = respuesta;
      });
      print(respuesta);
    } else {
      print('Error al procesar la solicitud');
    }
    print('Palabra Enviada: $palabra');
  }
}
