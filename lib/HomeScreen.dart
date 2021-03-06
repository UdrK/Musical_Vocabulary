import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Carousel.dart';
import 'NotesScreen.dart';
import 'QuizScreen.dart';
import 'QuizSettingsScreen.dart';
import 'ThemesScreen.dart';
import 'NotationScreen.dart';
import 'UserElementScreen.dart';
import 'BookmarksScreen.dart';
import 'PlayerScreen.dart';

/*
Home screen of the application. Lets the user change the settings using the
hamburger icon on the top left, browse the scales, chords and bookmarks
*/

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Musical Vocabulary',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: <Widget>[
              ListTile(
                tileColor: Theme.of(context).primaryColor,
                title: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThemesScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Themes",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      Icons.palette_outlined,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotationScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Notation",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      Icons.music_note,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlayerScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Player Settings",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizSettingsScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Quiz Settings",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      CupertinoIcons.question,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserElementScreen('Scales')),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Your Scales",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      Icons.settings,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserElementScreen('Chords')),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Your Chords",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      Icons.settings,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Carousel()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "Open Tutorial",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    leading: Icon(
                      CupertinoIcons.book,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen('Scales')),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Scales',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),

          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen('Chords')),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Chords',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),

          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Quiz',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),

          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarksScreen()),
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Bookmarks',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
