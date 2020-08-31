import 'package:flutter/material.dart';
import 'Notes.dart';
import 'MusicTheory.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          'Musical Vocabulary',
          style: Theme.of(context).textTheme.headline5,
        ),
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
      ),
      body: GridView.count(

        padding: const EdgeInsets.only(top: 3),
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        childAspectRatio: 16/4,

        children: [
          Material(
            color: Colors.blueGrey[800],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes('Scales')),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Scales',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),

          Material(
            color: Colors.blueGrey[800],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes('Chords')),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Chords',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}