import 'package:flutter/material.dart';
import 'NotesScreen.dart';
import 'ThemesScreen.dart';
import 'NotationScreen.dart';
import 'UserScalesScreen.dart';
import 'UserChordsScreen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Material(
        color: Colors.blueGrey[900],
        child: Container(
          child: Center(
            child: Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),

        ),
      ),
    );
  }
}

/*
        actions: <Widget> [
          PopupMenuButton(
            onSelected: (value) {
              MusicTheory.toggleNoteRepresentation(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'solfeggio',
                  child: Text('Solfeggio notation'),
                ),
                PopupMenuItem(
                  value: 'alphabet',
                  child: Text('Alphabet notation'),
                ),
              ];
            },
          ),
        ]
* */