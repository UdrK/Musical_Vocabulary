import 'package:flutter/material.dart';
import 'MusicTheory.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
This screen lets the user decide if the scale player will play notes in staccato
or legato style and set the bpm for the player.
*/

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreen createState() => _PlayerScreen();
}

class _PlayerScreen extends State<PlayerScreen> {
  String legato_staccato;
  int bpm;

  bool done = false;

  Future<bool> loadSettings() async {
    await SharedPreferences.getInstance().then((value) { legato_staccato = value.getString('legatoStaccato');});
    await SharedPreferences.getInstance().then((value) { bpm = value.getInt('bpm');});
    MusicTheory.changeBpm(bpm);
    MusicTheory.changeLegatoStaccato(legato_staccato);

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

  void _showFontSizeDialog() {
    showDialog<int>(
        barrierColor: Theme.of(context).backgroundColor,
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            initialIntegerValue: 60,
            minValue: 40,
            maxValue: 256,
            step: 2,
            title: new Text("Pick a BPM"),
          );
        }
    ).then((int value) {
      if (value != null) {
        setState(() => bpm = value);
        final prefs = SharedPreferences.getInstance();
        prefs.then((value) => value.setInt('bpm', bpm));
        MusicTheory.changeBpm(bpm);
      }
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
            'Pick a BPM',
            style: Theme.of(context).textTheme.headline5,
          )
      ),
      body: Column(
        children: <Widget>[
          Material(
            color: Theme
                .of(context)
                .cardColor,
            child: ListTile(
              title: Text(
                "BPM: $bpm",
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: _showFontSizeDialog,
            ),
          ),
          ListTile(
            tileColor: Theme
                .of(context)
                .primaryColor,
            title: Text(
              "Pick a playing style",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Staccato',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'staccato',
              groupValue: legato_staccato,
              onChanged: (String value) {
                setState(() {
                  legato_staccato = value;
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setString('legatoStaccato', 'staccato'));
                  MusicTheory.changeLegatoStaccato(legato_staccato);
                });
              },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Legato',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'legato',
              groupValue: legato_staccato,
              onChanged: (String value) {
                setState(() {
                  legato_staccato = value;
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setString('legatoStaccato', 'legato'));
                  MusicTheory.changeLegatoStaccato(legato_staccato);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

