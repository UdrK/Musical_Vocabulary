import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'Home.dart';

class NotationScreen extends StatefulWidget {
  @override
  _NotationScreen createState() => _NotationScreen();
}

class _NotationScreen extends State<NotationScreen> {

  String notation = 'alphabet';

  NotationScreen() {}

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
              onChanged: (String value) { setState(() { notation = value; }); },
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
              onChanged: (String value) { setState(() { notation = value; }); },
            ),
          ),
        ],
      ),
    );
  }
}

