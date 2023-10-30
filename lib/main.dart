/*Developer: Hugo Isaac Rodríguez Torres
  Name: Grades calculator.
  For: Curso para principiantes Dart+Flutter mobile apps, Sapiencia Ubicua, UDEA.
  Year: 2023
 */
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promedio de notas',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calcula tu calificación'),
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

  double nota1 = 0.0;
  double nota2 = 0.0;
  double nota3 = 0.0;
  double nota4 = 0.0;
  double promedio = 0.0;
  String mensaje = "";

  Future<void> showNegativeNumberDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Ups!'),
          content: Text('Debes ingresar números mayores o iguales a 0.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showOutOfRangeDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Ups!'),
          content: Text('La calificación debe estar en el rango de 0 a 5.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> showInvalidValuesDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Ups!'),
          content: Text('Por favor usa valores adecuados.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController nota1Controller = TextEditingController();
  TextEditingController nota2Controller = TextEditingController();
  TextEditingController nota3Controller = TextEditingController();
  TextEditingController nota4Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    nota1Controller.addListener(() {
      // Lógica para validar el valor en nota1Controller si es necesario
    });
    nota2Controller.addListener(() {
      // Lógica para validar el valor en nota2Controller si es necesario
    });
    nota3Controller.addListener(() {
      // Lógica para validar el valor en nota3Controller si es necesario
    });
    nota4Controller.addListener(() {
      // Lógica para validar el valor en nota4Controller si es necesario
    });
  }


  void calcularPromedio() {
    bool hasNegativeValues = nota1 < 0 || nota2 < 0 || nota3 < 0 || nota4 < 0;
    bool hasOutOfRangeValues = nota1 > 5 || nota2 > 5 || nota3 > 5 || nota4 > 5;
    bool hasInvalidInput = false;

    double? parsedNota1 = double.tryParse(nota1Controller.text);
    double? parsedNota2 = double.tryParse(nota2Controller.text);
    double? parsedNota3 = double.tryParse(nota3Controller.text);
    double? parsedNota4 = double.tryParse(nota4Controller.text);

    if (parsedNota1 == null || parsedNota2 == null || parsedNota3 == null || parsedNota4 == null) {
      hasInvalidInput = true;
    }

    if (hasNegativeValues && hasOutOfRangeValues) {
      showInvalidValuesDialog();
    } else {
      if (hasNegativeValues) {
        showNegativeNumberDialog();
      }
      if (hasOutOfRangeValues) {
        showOutOfRangeDialog();
      }
      if (hasInvalidInput) {
        showInvalidValuesDialog();
      }

      if (!hasNegativeValues && !hasOutOfRangeValues && !hasInvalidInput) {
        double nota1Value = parsedNota1 ?? 0.0;
        double nota2Value = parsedNota2 ?? 0.0;
        double nota3Value = parsedNota3 ?? 0.0;
        double nota4Value = parsedNota4 ?? 0.0;

        setState(() {
          promedio = (nota1Value + nota2Value + nota3Value + nota4Value) / 4;
          if (promedio >= 3.0) {
            mensaje = "Ganaste la materia!";
          } else {
            mensaje = "Perdiste la materia.";
          }
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nota1Controller,
              onChanged: (value) {
                nota1 = double.tryParse(value) ?? 0.0;
              },
              decoration: const InputDecoration(labelText: 'Nota 1'),
            ),
            TextField(
              controller: nota2Controller,
              onChanged: (value) {
                nota2 = double.tryParse(value) ?? 0.0;
              },
              decoration: const InputDecoration(labelText: 'Nota 2'),
            ),
            TextField(
              controller: nota3Controller,
              onChanged: (value) {
                nota3 = double.tryParse(value) ?? 0.0;
              },
              decoration: const InputDecoration(labelText: 'Nota 3'),
            ),
            TextField(
              controller: nota4Controller,
              onChanged: (value) {
                nota4 = double.tryParse(value) ?? 0.0;
              },
              decoration: const InputDecoration(labelText: 'Nota 4'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calcularPromedio,
              child: const Text('Calcular Promedio'),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Promedio: $promedio',
              style: const TextStyle(
                color: Colors.blue,  // Cambia el color al que desees
                fontSize: 16,        // Puedes ajustar el tamaño de fuente y otros atributos aquí
              ),
            ),
            Text(
              'Mensaje: $mensaje',
              style: TextStyle(
                color: promedio >= 3.0 ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
