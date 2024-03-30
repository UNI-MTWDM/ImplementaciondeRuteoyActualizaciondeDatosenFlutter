import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_01_ejercicio/ejercicios/todo_list.dart';
import 'package:flutter_01_ejercicio/stateless/stateless.dart';
import 'package:flutter_01_ejercicio/stateful/stateful.dart';

/**
 Dos tipos de Widgets:
  1. Stateless: No cambian su estado durante la ejecución de la aplicación.
    Textos, imágenes, botones, etc.

  2. Stateful: Pueden cambiar su estado durante la ejecución de la aplicación.
    Campos de texto, switch, checkbox, sliders, etc.
---
 */

/**
 * StatelessWidget
 */
class MiAplicacion extends StatelessWidget{
  // Identificador unico y requerido que flutter utiliza para identificar el widget volver a
  // reconstruirlo en el arbol de widgets de flutter
  const MiAplicacion({super.key});

  @override 
  Widget build(BuildContext context){
    return const CupertinoApp(
      title: "Mi Aplicación",
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,   // Para quitar la advertencia del Debug
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
    );
  }

}

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context){
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Mi página principal"),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Text("Texto 1"),
            Text("Texto 2"),
            Text("Texto 3"),
            Texto(texto: "Mi texto personalizado"),
            Lista(),
            NewsCard(
              title: "Conejos salvajes",
              source: "Milenio",
              date: "Hoy",
              imagePath: "assets/images/rabbits.jpg",
            ),
            CambioColorWidget(),
            ContadorWidget(valorInicial: 7),
          ],
        ),
      ));
  }
}