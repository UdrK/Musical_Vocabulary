import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'LoadingScreen.dart';
import 'MusicTheory.dart';
import 'UserFile.dart';

/*
This screen shows the user either a list of Scales or Chords depending on what
the user selected in the home screen
*/

class ResultsScreen extends StatefulWidget {
  String note;
  String user_choice;

  ResultsScreen(note, user_choice) {
    this.note = note;
    this.user_choice = user_choice;
  }

  @override
  _ResultsScreen createState() => _ResultsScreen(note, user_choice);
}
class _ResultsScreen extends State<ResultsScreen> {
  final _flutterMidi = FlutterMidi(); // TODO: MIDI
  UserFile bookmarksFile;
  UserFile file;
  String note;
  String user_choice;
  List<String> scales_or_chords;
  List<String> bookmarks;
  bool done = false;
  List<bool> playing;

  _ResultsScreen(String note, String user_choice) {
    this.bookmarksFile = new UserFile('Bookmarks');
    this.file = new UserFile(user_choice);
    this.user_choice = user_choice;
    this.note = note;
  }

  void load() async {
    _flutterMidi.unmute();
    await rootBundle.load("assets/soundfonts/Yamaha-Grand-Lite-v2.0.sf2").then((sf2) {
      _flutterMidi.prepare(sf2: sf2, name: "Yamaha-Grand-Lite-v2.0.sf2");
    });
  }

  @override
  void initState() {
    load();
    bookmarks = [];
    playing = [];
    bookmarksFile.read().then((List<String> value) {
      value.forEach((element) => (bookmarks.add(element)));
    });

    if (user_choice == 'Scales') {
      file.read().then((List<String> value) {
        setState(() {
          if (value != null) {
            for(int i=0; i<value.length; i+=2) {
              MusicTheory.scales_map[value[i]] = value[i+1];
            }
          }
          scales_or_chords = MusicTheory.scales(note);
          for(int i=0; i<scales_or_chords.length; i+=1) {
            playing.add(false);
          }
          done=true;
        });
      });
    } else if (user_choice == 'Chords') {
      file.read().then((List<String> value) {
        setState(() {
          if (value != null) {
            for(int i=0; i<value.length; i+=2) {
              MusicTheory.chords_map[value[i]] = value[i+1];
            }
          }
          scales_or_chords = MusicTheory.chords(note);
          for(int i=0; i<scales_or_chords.length; i+=1) {
            playing.add(false);
          }
          done=true;
        });
      });
    }

  }
  
  Icon bookmarkIcon(element) {
    if (bookmarks.isNotEmpty) {
      if(!bookmarks.contains(element))
        return Icon(Icons.bookmark_border);
      else
        return Icon(Icons.bookmark);
    }
    else {
      return Icon(Icons.bookmark_border);
    }
  }

  void play(List<int> midiNotes, int index) async {
    setState(() {
      playing[index] = true;
    });
    for(int i=0; i<midiNotes.length; i+=1) {
      if (playing[index]) {
        _flutterMidi.playMidiNote(midi: midiNotes[i]);
        await Future.delayed(Duration(milliseconds: MusicTheory.note_duration));
        _flutterMidi.stopMidiNote(midi: midiNotes[i]);
        await Future.delayed(Duration(milliseconds: MusicTheory.interval_between_notes));
      }
    }
    setState(() {
      playing[index] = false;
    });
  }

  void stop(int index) async {
    setState(() {
      playing[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!done) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      );
    } else {
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
                          Expanded(
                            flex: 7,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    this.scales_or_chords[i],
                                    style: Theme.of(context).textTheme.headline4,
                                  ),
                                  Flexible(
                                    child: Text(
                                      this.scales_or_chords[i+1],
                                      style: Theme.of(context).textTheme.headline6,
                                      maxLines: 2,
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: bookmarkIcon(this.scales_or_chords[i]),
                                onPressed: () {
                                  if (bookmarks.isEmpty || !bookmarks.contains(this.scales_or_chords[i])) {
                                    setState(() {
                                      bookmarksFile.write(this.scales_or_chords[i], this.scales_or_chords[i+1]);
                                      bookmarks.add(this.scales_or_chords[i]);
                                      bookmarks.add(this.scales_or_chords[i+1]);
                                    });
                                  } else {
                                    setState(() {
                                      bookmarksFile.remove(this.scales_or_chords[i]);
                                      bookmarks.remove(this.scales_or_chords[i]);
                                      bookmarks.remove(this.scales_or_chords[i+1]);
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: (playing[i]) ? Icon(Icons.stop) : Icon(Icons.play_arrow),
                                //alignment: Alignment.centerRight,
                                tooltip: 'Play',
                                onPressed: () {
                                  List<int> midiNotes = MusicTheory.midi(this.scales_or_chords[i + 1]);
                                  if (playing[i]) {
                                    stop(i);
                                  } else play(midiNotes, i);
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
