import 'package:flutter/material.dart';
import 'Home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[700],
        cardColor: Colors.blueGrey[900],
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),

          headline5: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),

          headline4: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),

        ),
      ),

      home: Home(),
    );
  }
}



