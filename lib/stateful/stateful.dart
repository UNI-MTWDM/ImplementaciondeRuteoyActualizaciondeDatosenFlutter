import 'package:flutter/cupertino.dart';
import 'dart:math';

/*
Los Widgets Statefuls tienenn dos clases, una que se encarga del contenido y otra del estado
1.- La clase que extiende de StatefulWidget -> Se encarga de defionir el estado
2.- La clase que extiende de State -> Se encarga de construir el wodget y manejar el estado
--
StatefelWidget -> Inmutable (No puede cambiar sus propiedades Internas)
State -> Mutable (Puede cambiar sus propiedades internas)
*/

class CambioColorWidget extends StatefulWidget{
  const CambioColorWidget(
    {super.key});  // const CambiosColorWidget({Key?: key}): super(key: key);

  @override
  State<CambioColorWidget> createState() => _CambioColorWidgetState();
}

class _CambioColorWidgetState extends State<CambioColorWidget>{
  Color _color = CupertinoColors.destructiveRed;
  
  @override
  Widget build(BuildContext context){
    return  Column(
      children: [
        CupertinoButton(
          child: Text("Cambiar color"),
          onPressed: () => {
            setState(() {
              _color = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1);
            })
          },),  
        Container(width: 100, height: 100, color: _color,)
      ],
    );
  }
}



class ContadorWidget extends StatefulWidget {
  final int valorInicial;
  const ContadorWidget({super.key, required this.valorInicial});

  @override
  State<ContadorWidget> createState() => _ContadorWidgetSate();

}

class _ContadorWidgetSate extends State<ContadorWidget>{
  int _contador = 0;

  @override
  void initState(){
    super.initState();
    _contador = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        CupertinoButton(child: Text("$_contador | Añadir"),
          onPressed: () => {
            setState(() {
              _contador++;
            })
          })
      ],
    );
  }
}