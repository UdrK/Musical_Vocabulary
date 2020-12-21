import 'package:flutter/material.dart';
import 'LoadingScreen.dart';
import 'MusicTheory.dart';
import 'UserFile.dart';

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

  UserFile bookmarksFile;
  UserFile file;
  String note;
  String user_choice;
  List<String> scales_or_chords;
  List<String> bookmarks;
  bool done = false;

  _ResultsScreen(String note, String user_choice) {
    this.bookmarksFile = new UserFile('Bookmarks');
    this.file = new UserFile(user_choice);
    this.user_choice = user_choice;
    this.note = note;
  }

  @override
  void initState() {
    bookmarks = [];
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
          scales_or_chords = MusicTheory(note).scales();
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
          scales_or_chords = MusicTheory(note).chords();
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
  
  @override
  Widget build(BuildContext context) {
    if (!done) {
      return MaterialApp(
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
                                icon: bookmarkIcon(this.scales_or_chords[i]),
                                tooltip: 'Save to favorites',
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
