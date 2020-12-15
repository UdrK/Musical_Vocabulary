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
        primaryColor: Colors.blueGrey[700],   // app bar color
        cardColor: Colors.blueGrey[800],      // cards or tiles color
        backgroundColor: Colors.blueGrey[900],  // background
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(     // notes
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),

          headline5: TextStyle(     // titles
            fontSize: 24,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),

          headline4: TextStyle(     // names
            fontSize: 20,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),

        ),
      ),

      home: Home(),
    );
  }
}

/*

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[700],   // app bar color
        cardColor: Colors.blueGrey[800],      // cards or tiles color
        backgroundColor: Colors.blueGrey[900],  // background
        textTheme: TextTheme(
          headline6: TextStyle(     // notes
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),

          headline5: TextStyle(     // titles
            fontSize: 24,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),

          headline4: TextStyle(     // names
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

*/

