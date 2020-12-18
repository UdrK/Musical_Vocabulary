import 'package:flutter/material.dart';
import 'package:musical_vocabulary/LoadingScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class UserScalesFile {

  String filename = 'user_scales.txt';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/'+filename);
  }

  Future<List<String>> readScales() async {
    try {
      final file = await _localFile;
      String file_content = await file.readAsString();
      List<String> scales = file_content.split('\n');
      if (scales.isNotEmpty)
        scales.removeLast();
      return scales;
    } catch (e) {}
  }

  Future<File> writeScale(String name, String pattern) async {
    final file = await _localFile;
    await file.writeAsString('$name\n$pattern\n', mode: FileMode.append);
    return file;
  }

  Future<File> removeScale(String name) async {
    List<String> scales = await readScales();
    final file = await _localFile;
    await file.writeAsString('', mode: FileMode.write); //clears file
    int i = 0;
    for (i=0; i<scales.length; i+=2) {
      if(name != scales[i]) {                   // writes every other scale
        await writeScale(scales[i], scales[i+1]);
      }
    }
    return file;
  }
}

class UserScalesScreen extends StatefulWidget {
  UserScalesFile file = new UserScalesFile();
  @override
  _UserScalesScreen createState() => _UserScalesScreen();
}

class _UserScalesScreen extends State<UserScalesScreen> {

  List<String> user_scales;
  bool done = false;
  TextEditingController _textFieldNameController = TextEditingController();
  TextEditingController _textFieldPatternController = TextEditingController();

  // reads scales from file
  @override
  void initState() {
    widget.file.readScales().then((List<String> value) {
      setState(() {
        user_scales = ['Tap green button to add a scale', 'Tap bin to delete a scale'];
        if (value != null) {
          value.forEach((element) {
            user_scales.add(element);
          });
        }
        done = true;
      });
    });
  }

  Future<File> writeScale(String name, String pattern) {
    setState(() {
      user_scales.add(name);
      user_scales.add(pattern);
    });

    return widget.file.writeScale(name, pattern);
  }

  Future<File> removeScale(String name, String pattern) {
    setState(() {
      user_scales.remove(name);
      user_scales.remove(pattern);
    });

    return widget.file.removeScale(name);
  }

  void _showHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add Scale Help',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("The name shouldn't include 'Scale' as the app adds it on its own."),
                  Text(""),
                  Text("The pattern refers to how many semitones you should jump from the previous note to get a note in the scale. For example, in the major scale that is: W W H W W W H (don't put spaces in the pattern)."),
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
            'Add Scale',
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
                decoration: InputDecoration(hintText: "Scale name (e.g. Major)"),
              ),
              TextField(
                controller: _textFieldPatternController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "Scale pattern (e.g. WWHWWWH)"),
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
                writeScale(name, pattern);
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
              'User Scales',
              style: Theme.of(context).textTheme.headline5,
            )
        ),
        body: GridView.count(

          padding: const EdgeInsets.only(top: 3),
          crossAxisCount: 1,
          mainAxisSpacing: 3,
          childAspectRatio: 16/4,

          children: [
            for(int i=0; i<this.user_scales.length; i+=2)
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
                                  this.user_scales[i],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  this.user_scales[i+1],
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
                                    removeScale(this.user_scales[i], this.user_scales[i+1]);
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
