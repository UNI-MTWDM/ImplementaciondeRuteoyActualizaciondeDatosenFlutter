import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PrimaVacacional extends StatelessWidget {
  const PrimaVacacional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomePrimaVacacional(),
      title: "Prima Vacacional",
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemGreen,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
 Widget poner listado de Items de prima vacional
*/
class HomePrimaVacacional extends StatefulWidget {
  const HomePrimaVacacional({super.key});

  @override
  State<HomePrimaVacacional> createState() => _HomePrimaVacacionalState();
}

class _HomePrimaVacacionalState extends State<HomePrimaVacacional> {
  List<PrimaVacacionalItem> _items = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Listado"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add), onPressed: () {
            //Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => AgregarPrimaVacacional()));
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) =>  AgregarPrimaVacacional(
                  onAgregar: (item) {
                    setState(() {
                      _items.add(item);
                    });
                    Navigator.of(context).pop();
                  }
                )
              )
            );
          }
        ),
      ),
      child:  SafeArea(
        child: ListView.builder (
          itemCount: _items.length,
          itemBuilder: (context, index){
            return CupertinoListTile(

              /* *************************
              // Aqui debemos agregar un boton para actualizar el item
              ************************* */

              title: Text(_items[index].nombreCompleto),
              subtitle: Text('Prima vacacional:' 
                '${NumberFormat.currency(symbol: "\$").format(_items[index].primaVacacionalBruta)}'),
                trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.refresh),
                onPressed: () {
                  _updateItem(index);
                },
              ),
            );
          },
        ),
      )
    );
  }


/*
 Widget poner listado de Items de prima vacional
*/
  void _updateItem(int index) {
    PrimaVacacionalItem selectedItem = _items[index];
    
    // Mostrar un diálogo que contiene el widget ActualizarPrimaVacacional
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: ActualizarPrimaVacacional(
            item: selectedItem,
            onUpdate: (updatedItem) {
              setState(() {
                _items[index] = updatedItem;
              });
            },
          ),
        );
      },
    );
  }
  
}

class PrimaVacacionalItem{
  final String id;
  String nombreCompleto;
  final double sueldoMensualBruto;
  final int diasVacaciones;
  final int porcentajePrimaVacacional;
  double primaVacacionalBruta;

  PrimaVacacionalItem({
    required this.nombreCompleto,
    required this.sueldoMensualBruto,
    required this.diasVacaciones,
    required this.porcentajePrimaVacacional,
    required this.primaVacacionalBruta
  }) : id = UniqueKey().toString();
}

/* 
  Widget para agregar Item en la lista de prima vacacional
*/
class AgregarPrimaVacacional extends StatefulWidget {
  const AgregarPrimaVacacional({super.key, required this.onAgregar});
  final Function(PrimaVacacionalItem) onAgregar;

  @override
  State<AgregarPrimaVacacional> createState() => _AgregarPrimaVacacionalState();
}

class _AgregarPrimaVacacionalState extends State<AgregarPrimaVacacional> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _sueldoMensualController = TextEditingController();
  final _diasVacacionesController = TextEditingController();
  final _porcentajePrimaVacacionalController = TextEditingController();
  double _primaVacacionalBruta = 0.0;

  void _calcular() {
    setState(() {
      _primaVacacionalBruta = ( (double.tryParse(_sueldoMensualController.text)! / 30) * 
      int.tryParse(_diasVacacionesController.text)! ) * 
      (double.tryParse(_porcentajePrimaVacacionalController.text)! / 100);
    });
  }

  @override
  void initState() {
    // La llaada a super.initState() debe ser la primera línea en el método
    super.initState();
    _nombreController.addListener(_calcular);
    _apellidoController.addListener(_calcular);
    _sueldoMensualController.addListener(_calcular);
    _diasVacacionesController.addListener(_calcular);
  }

  @override
  void dispose(){
    _nombreController.removeListener(_calcular);
    _apellidoController.removeListener(_calcular);
    _sueldoMensualController.removeListener(_calcular);
    _diasVacacionesController.removeListener(_calcular);
    // Se debe llamar hasta el final, para librer los recursos correspondientes
    super.dispose();
  }



  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Agregar prima"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add_circled), 
          onPressed: () {
            widget.onAgregar(PrimaVacacionalItem(
              nombreCompleto: "${_nombreController.text} ${_apellidoController.text}",
              sueldoMensualBruto: double.tryParse(_sueldoMensualController.text)!,
              diasVacaciones: int.tryParse(_diasVacacionesController.text)!,
              porcentajePrimaVacacional: int.tryParse(_porcentajePrimaVacacionalController.text)!,
              primaVacacionalBruta: _primaVacacionalBruta
            ));
          }),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre + Apellido
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nombre:"), 
                        CupertinoTextField(
                          controller: _nombreController)
                          ,
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Apellido:"), 
                        CupertinoTextField(
                          controller: _apellidoController
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text("Sueldo Mensual Bruto:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                ],
                controller: _sueldoMensualController),
              const SizedBox(
                height: 8,
              ),
              const Text("Días de Vacaciones:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _diasVacacionesController),
              const SizedBox(
                height: 8,
              ),
              const Text("Porcentaje de Prima Vacacional:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _porcentajePrimaVacacionalController),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                height: 1, 
                indent: 20, 
                endIndent:20),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Prima Vacacional:", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Empleado:"), 
                  Text("${_nombreController.text} ${_apellidoController.text}"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Prima Vacacional:"),
                  Text(NumberFormat.currency(symbol: "\$")
                  .format(_primaVacacionalBruta)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      )
    );
  }
}




class ActualizarPrimaVacacional extends StatefulWidget {
  final PrimaVacacionalItem item;
  final Function(PrimaVacacionalItem) onUpdate;

  const ActualizarPrimaVacacional({Key? key, required this.item, required this.onUpdate}) : super(key: key);

  @override
  _ActualizarPrimaVacacionalState createState() => _ActualizarPrimaVacacionalState();
}

class _ActualizarPrimaVacacionalState extends State<ActualizarPrimaVacacional> {
  late TextEditingController _nombreController;
  late TextEditingController _sueldoMensualController;
  late TextEditingController _diasVacacionesController;
  late TextEditingController _porcentajePrimaVacacionalController;
  late double _primaVacacionalBruta;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.item.nombreCompleto);
    _sueldoMensualController = TextEditingController(text: widget.item.sueldoMensualBruto.toString());
    _diasVacacionesController = TextEditingController(text: widget.item.diasVacaciones.toString());
    _porcentajePrimaVacacionalController = TextEditingController(text: widget.item.porcentajePrimaVacacional.toString());
    _primaVacacionalBruta = widget.item.primaVacacionalBruta;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _sueldoMensualController.dispose();
    _diasVacacionesController.dispose();
    _porcentajePrimaVacacionalController.dispose();
    super.dispose();
  }

  void _calcular() {
    setState(() {
      _primaVacacionalBruta = ((double.tryParse(_sueldoMensualController.text)! / 30) * int.tryParse(_diasVacacionesController.text)!) * (double.tryParse(_porcentajePrimaVacacionalController.text)! / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Actualizar Prima"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Guardar'),
          onPressed: () {
            widget.onUpdate(PrimaVacacionalItem(
              nombreCompleto: _nombreController.text,
              sueldoMensualBruto: double.tryParse(_sueldoMensualController.text)!,
              diasVacaciones: int.tryParse(_diasVacacionesController.text)!,
              porcentajePrimaVacacional: int.tryParse(_porcentajePrimaVacacionalController.text)!,
              primaVacacionalBruta: _primaVacacionalBruta,
            ));
            Navigator.of(context).pop();
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Nombre:"),
              CupertinoTextField(
                controller: _nombreController,
              ),
              const SizedBox(height: 8),
              const Text("Sueldo Mensual Bruto:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: _sueldoMensualController,
                onChanged: (_) => _calcular(),
              ),
              const SizedBox(height: 8),
              const Text("Días de Vacaciones:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _diasVacacionesController,
                onChanged: (_) => _calcular(),
              ),
              const SizedBox(height: 8),
              const Text("Porcentaje de Prima Vacacional:"),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _porcentajePrimaVacacionalController,
                onChanged: (_) => _calcular(),
              ),
              const SizedBox(height: 30),
              const Divider(height: 1, indent: 20, endIndent: 20),
              const SizedBox(height: 30),
              const Text("Prima Vacacional:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Empleado:"),
                  Text(_nombreController.text),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Prima Vacacional:"),
                  Text(NumberFormat.currency(symbol: "\$").format(_primaVacacionalBruta)),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
