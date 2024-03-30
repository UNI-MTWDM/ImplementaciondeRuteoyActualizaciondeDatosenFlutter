import 'package:flutter/cupertino.dart';

class Texto extends StatelessWidget{
  final String texto;
  const Texto({super.key, required this.texto});

  @override
  Widget build (BuildContext context) {
    return Text(
      texto, 
      style: const TextStyle(
        color: CupertinoColors.systemCyan,
        decoration: TextDecoration.underline)
    );
    }
}

class Lista extends StatelessWidget{
  const Lista({super.key});

  @override
  Widget build(BuildContext context){
    return Column(

      children:[
        ListView(
          // Cear "contenedor" para ajustar el tamaño del contenido. -> Scroll
          shrinkWrap: true ,
          children:[
            for (var i = 0; i<10; i++)
              Text("Elemento $i"),
          ],
        ),
      ],
    );
  }
}

// Estilos
var cardBoxDecoration = BoxDecoration(
  color: CupertinoColors.white,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(
      color: CupertinoColors.systemGrey.withOpacity(0.5),
    blurRadius: 10,
    offset: const Offset(0, 2),
    )
]);

var titleTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 14,
);
var sourceTextStyle = const TextStyle(
  color: CupertinoColors.systemGrey,
  fontSize: 12,
);
var dateTextStyle = TextStyle(
  color: CupertinoColors.systemGrey.withOpacity(0.9),
  fontSize: 10,
);
// Estilos FIN


// Widget Tarjeta
class NewsCard extends StatelessWidget {
  final String title;
  final String source;
  final String date;
  final String imagePath;

  const NewsCard(
    {Key? key,
    required this.title,
    required this.source,
    required this.date,
    required this.imagePath})
    : super(key: key);

  @override
  Widget build(BuildContext){
    return Container(
      decoration: cardBoxDecoration,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(
            imagePath, 
            width: 100, 
            height: 100,
            fit:BoxFit.cover
          ),
          const SizedBox(width: 10),
          Column(
            // crossAxisAlignment: Es una propiedad que controla como se alinean los hijos en elñ eje cruzado
            // Es decir si la columna, su eje principal es vertical, y el eje cruzado es horizontal
            // Filas -> eje principal horizontal, eje cruzado vertical
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(source, style: sourceTextStyle),
              const SizedBox(height: 5),
              Text(title, style:titleTextStyle),
              const SizedBox(height: 5),
              Text(date, style: dateTextStyle),
            ],)
          ],
        ),
      );
    }
}