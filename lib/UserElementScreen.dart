import 'package:flutter/material.dart';
import 'LoadingScreen.dart';
import 'UserFile.dart';
import 'dart:async';
import 'dart:io';

/*
This screen lets the user save a custom scale or chord based on what has been
chosen in the hamburger menu in the home screen
*/

class UserElementScreen extends StatefulWidget {
  UserFile file;
  String element;
  UserElementScreen(String element) {
    this.element = element;
    if (element == 'Scales' || element == 'Chords') {
      file = new UserFile(element);
    }
  }

  @override
  _UserElementScreen createState() => _UserElementScreen();
}

class _UserElementScreen extends State<UserElementScreen> {
  List<String> instructions;
  List<String> user_elements;
  String title;
  String help_title;
  String add_title;
  String hint_name;
  String hint_pattern;
  bool done = false;
  TextEditingController _textFieldNameController = TextEditingController();
  TextEditingController _textFieldPatternController = TextEditingController();

  // reads elements from file
  @override
  void initState() {
    widget.file.read().then((List<String> value) {
      setState(() {
        if (widget.element == 'Scales') {
          instructions = ['The green button adds scales', 'The bin button deletes a scale'];
          user_elements = [];
          title = 'User Scales';
          help_title = 'Add Scale Help';
          add_title = 'Add Scale';
          hint_name = 'Scale name (e.g. Major)';
          hint_pattern = 'Scale pattern (e.g. WWHWWWH)';
        }
        else {
          instructions = ['The green button adds chords', 'The bin button deletes a chord'];
          user_elements = [];
          title = 'User Chords';
          help_title = 'Add Chord Help';
          add_title = 'Add Chord';
          hint_name = 'Chord name (e.g. Major Triad)';
          hint_pattern = 'Chord pattern (e.g. MP)';
        }
        if (value != null) {
          value.forEach((element) {
            user_elements.add(element);
          });
        }
        done = true;
      });
    });
  }

  Future<File> writeElement(String name, String pattern) {
    setState(() {
      user_elements.add(name);
      user_elements.add(pattern);
    });

    return widget.file.write(name, pattern);
  }

  Future<File> removeElement(String name, String pattern) {
    setState(() {
      user_elements.remove(name);
      user_elements.remove(pattern);
    });

    return widget.file.remove(name);
  }

  void _showHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              help_title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("The name shouldn't include 'Scale' or 'Chord'."),
                  Text(""),
                  Text("The pattern refers to how many semitones you should jump from the previous note to get a note in the scale or chord. For example, in the major scale that is: W W H W W W H (don't put spaces in the pattern)."),
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
            add_title,
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
                decoration: InputDecoration(hintText: hint_name),
              ),
              TextField(
                controller: _textFieldPatternController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: hint_pattern),
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
                writeElement(name, pattern);
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
              title,
              style: Theme.of(context).textTheme.headline5,
            )
        ),
        body: GridView.count(

          padding: const EdgeInsets.only(top: 3),
          crossAxisCount: 1,
          mainAxisSpacing: 3,
          childAspectRatio: 16/4,

          children: [
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
                                this.instructions[0],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                this.instructions[1],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ]
                        ),
                      ],
                    )
                ),
              ),
            ),
            for(int i=0; i<this.user_elements.length; i+=2)
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
                                  this.user_elements[i],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  this.user_elements[i+1],
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
                                  removeElement(this.user_elements[i], this.user_elements[i+1]);
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
