import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'Home.dart';

class UserChordsScreen extends StatelessWidget {

  List<String> user_chords;
  TextEditingController _textFieldNameController = TextEditingController();
  TextEditingController _textFieldPatternController = TextEditingController();

  UserChordsScreen() {
    this.user_chords = ['Chord1Name', 'chord1pattern', 'Chord2Name', 'chord2pattern'];  //TODO: GET THEM FROM FILE
  }

  List<String> readChords() {
    // TODO: READ SCALES FROM FILE
  }

  void writeChord() {
    // TODO: WRITE SCALE TO FILE
  }

  void removeChord() {
    // TODO: REMOVE SCALE
  }

  void _showHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add Chord Help',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("The name shouldn't include 'Chord'."),
                  Text(""),
                  Text("The pattern refers to how many semitones you should jump from the previous note to get a note in the chord. For example, in the major triad that is: M P (don't put spaces in the pattern)."),
                  Text(""),
                  Text("• 1 semitone: H"),
                  Text("• 2 semitones: W"),
                  Text("• 3 semitones: m"),
                  Text("• 4 semitones: M"),
                  Text("• 5 semitones: p"),
                  Text("• 6 semitones: d"),
                  Text("• 7 semitones: P"),
                  Text("• 8 semitones: A"),
                  Text("• 9 semitones: D"),
                  Text("• 10 semitones: s"),
                  Text("• 11 semitones: S"),
                ]
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Chord',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textFieldNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "Chord name (e.g. Major Triad)"),
              ),
              TextField(
                controller: _textFieldPatternController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "Chord pattern (e.g. MP)"),
              ),
            ]
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Help'),
              onPressed: () {
                _showHelp(context);
              },
            ),
            new FlatButton(
              child: new Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
          title: Text(
            'User Chords',
            style: Theme.of(context).textTheme.headline5,
          )
      ),
      body: GridView.count(

        padding: const EdgeInsets.only(top: 3),
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        childAspectRatio: 16/4,

        children: [
          for(int i=0; i<this.user_chords.length; i+=2)
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
                                this.user_chords[i],
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Text(
                                this.user_chords[i+1],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete_forever),
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
