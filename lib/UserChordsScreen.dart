import 'package:flutter/material.dart';
import 'package:musical_vocabulary/LoadingScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class UserChordsFile {

  String filename = 'user_chords.txt';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/'+filename);
  }

  Future<List<String>> readChords() async {
    try {
      final file = await _localFile;
      String file_content = await file.readAsString();
      List<String> chords = file_content.split('\n');
      if (chords.isNotEmpty)
        chords.removeLast();
      return chords;
    } catch (e) {}
  }

  Future<File> writeChord(String name, String pattern) async {
    final file = await _localFile;
    await file.writeAsString('$name\n$pattern\n', mode: FileMode.append);
    return file;
  }

  Future<File> removeChord(String name) async {
    List<String> chords = await readChords();
    final file = await _localFile;
    await file.writeAsString('', mode: FileMode.write); //clears file
    int i = 0;
    for (i=0; i<chords.length; i+=2) {
      if(name != chords[i]) {                   // writes every other chord
        await writeChord(chords[i], chords[i+1]);
      }
    }
    return file;
  }
}

class UserChordsScreen extends StatefulWidget {
  UserChordsFile file = new UserChordsFile();
  @override
  _UserChordsScreen createState() => _UserChordsScreen();
}

class _UserChordsScreen extends State<UserChordsScreen> {

  List<String> user_chords;
  bool done = false;
  TextEditingController _textFieldNameController = TextEditingController();
  TextEditingController _textFieldPatternController = TextEditingController();

  // reads chords from file
  @override
  void initState() {
    widget.file.readChords().then((List<String> value) {
      setState(() {
        user_chords = ['Tap green button to add a chord', 'Tap bin to delete a chord'];
        if (value != null) {
          value.forEach((element) {
            user_chords.add(element);
          });
        }
        done = true;
      });
    });
  }

  Future<File> writeChord(String name, String pattern) {
    setState(() {
      user_chords.add(name);
      user_chords.add(pattern);
    });

    return widget.file.writeChord(name, pattern);
  }

  Future<File> removeChord(String name, String pattern) {
    setState(() {
      user_chords.remove(name);
      user_chords.remove(pattern);
    });

    return widget.file.removeChord(name);
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
                  Text("The name shouldn't include 'Chord' as the app adds it on its own."),
                  Text(""),
                  Text("The pattern refers to how many semitones you should jump from the previous note to get a note in the chord. For example, in the major chord that is: M P (don't put spaces in the pattern)."),
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
                  String name = _textFieldNameController.text;
                  String pattern = _textFieldPatternController.text;
                  writeChord(name, pattern);
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!done) {
      return MaterialApp(
        home: LoadingScreen(),
      );
    } else {
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
                                tooltip: 'Delete',
                                onPressed: () {
                                  if(i != 0)
                                    removeChord(this.user_chords[i], this.user_chords[i+1]);
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
}
