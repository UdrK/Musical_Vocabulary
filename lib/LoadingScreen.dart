import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Material(
        color: Colors.grey[100],
        child: Container(
          child: Center(
            child: Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
