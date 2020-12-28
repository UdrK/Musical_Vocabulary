import 'package:flutter/material.dart';
import 'MusicTheory.dart';
import 'ResultsScreen.dart';

/*
This screen lets the user pick a root note
*/

class NotesScreen extends StatelessWidget {
  String origin;

  NotesScreen(String origin) {
    this.origin = origin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text(
            'Choose a root note',
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
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsScreen(MusicTheory.notes[i], this.origin)),
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