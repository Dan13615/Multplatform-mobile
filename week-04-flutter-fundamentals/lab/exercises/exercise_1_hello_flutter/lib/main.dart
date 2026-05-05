import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  1: Change the title to something healthcare-related,
      //         e.g., "Health Counter" or "Patient Tracker".
      title: 'Health Counter',
      theme: ThemeData(
        //  2: Change the color scheme seed to a different color.
        //         Try Colors.teal, Colors.green, or Colors.red.
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Health Counter Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //  4: Create a new method called _decrementCounter that
  //         decreases _counter by 1. Remember to wrap the change
  //         in setState(() { ... }).

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //  1 (continued): Update this title to match your new app name.
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),

            // 3: Add an Icon widget ABOVE or NEXT to the counter text.
            //         For example: Icon(Icons.favorite, color: Colors.red, size: 48)
            //         You can use a Row widget to place the icon next to the text,
            //         or simply add the Icon as another child of the Column.
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Icon(Icons.favorite, color: Colors.red, size: 48),
          ],
        ),
      ),
      // 4 (continued): Change this FloatingActionButton so that it
      //         calls _decrementCounter instead of _incrementCounter.
      //         Also change the icon from Icons.add to Icons.remove.
      floatingActionButton: FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Decrement',
        child: const Icon(Icons.remove),
      ),
    );
  }
}
