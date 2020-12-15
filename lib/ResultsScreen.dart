import 'package:flutter/material.dart';
import 'MusicTheory.dart';

class ResultsScreen extends StatelessWidget {

  String note;
  List<String> scales_or_chords;

  ResultsScreen(String note, String scales_or_chords) {
    this.note = note;
    if (scales_or_chords == "Scales") {
      this.scales_or_chords = MusicTheory(note).scales();
    } else if (scales_or_chords == "Chords") {
      this.scales_or_chords = MusicTheory(note).chords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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

        children: [
          for(int i=0; i<this.scales_or_chords.length; i+=2)
          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.scales_or_chords[i],
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            this.scales_or_chords[i+1],
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          tooltip: 'Save to favorites',
                          onPressed: () {
                            // TODO: Save to favorites
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          //alignment: Alignment.centerRight,
                          tooltip: 'Save to favorites',
                          onPressed: () {
                            // TODO: Save to favorites
                          },
                        ),
                      ],
                    ),

                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*
IconButton(
  icon: Icon(Icons.favorite),
  tooltip: 'Save to favorites',
  onPressed: () {
    // TODO: Save to favorites
  },
),
*/