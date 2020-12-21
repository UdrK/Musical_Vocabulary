import 'package:flutter/material.dart';
import 'MusicTheory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotationScreen extends StatefulWidget {
  @override
  _NotationScreen createState() => _NotationScreen();
}

class _NotationScreen extends State<NotationScreen> {
  String notation;

  bool done = false;

  Future<bool> loadSettings() async {
    await SharedPreferences.getInstance().then((value) { notation = value.getString('notation');});
    MusicTheory.changeNoteRepresentation(notation);
    return true;
  }

  @override
  void initState() {
    loadSettings().then((value) {
      setState(() {
        done = value;
      });
    });
  }

  @override
  State<StatefulWidget> createState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text(
            'Choose the notation',
            style: Theme.of(context).textTheme.headline5,
          )
      ),
      body: Column(
        children: <Widget>[
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Alphabet notation (A, A#, B, ..)',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'alphabet',
              groupValue: notation,
              onChanged: (String value) {
                setState(() {
                  notation = value;
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setString('notation', 'alphabet'));
                  MusicTheory.changeNoteRepresentation(notation);
                });
              },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Solfeggio notation (Do, Do#, Re, ..)',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'solfeggio',
              groupValue: notation,
              onChanged: (String value) {
                setState(() {
                  notation = value;
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setString('notation', 'solfeggio'));
                  MusicTheory.changeNoteRepresentation(notation);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

