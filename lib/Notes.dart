import 'package:flutter/material.dart';
import 'package:music_vocabulary/MusicTheory.dart';
import 'Scales.dart';
import 'Chords.dart';

class Notes extends StatelessWidget {

  String origin;

  Notes(String origin) {
    this.origin = origin;
  }

  dynamic routeTap(String note) {
    if (origin == 'Scales') {
      return Scales(note);
    } else if (origin == 'Chords') {
      return Chords(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          title: Text(
            'Musical Vocabulary',
            style: Theme.of(context).textTheme.headline5,
          )
      ),
      body: GridView.count(

        padding: const EdgeInsets.only(top: 3),
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        childAspectRatio: 16/4,

        children: [for(int i=0;i<MusicTheory.notes.length;i+=1)
          Material(
            color: Colors.blueGrey[800],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => routeTap(MusicTheory.notes[i])),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  MusicTheory.notes[i],
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}