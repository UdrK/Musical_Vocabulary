import 'package:flutter/material.dart';
import 'MusicTheory.dart';

class Scales extends StatelessWidget {

  String note;
  List<String> scales;

  Scales(String note) {
    this.note = note;
    this.scales = MusicTheory(note).scales();
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

        children: [for(int i=0; i<this.scales.length; i+=2)
          Material(
            color: Colors.blueGrey[800],
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.scales[i],
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      this.scales[i+1],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ]
                ),
              ),
            ),
        )
        ],
      ),
    );
  }
}

