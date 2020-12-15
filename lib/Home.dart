import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NotesScreen.dart';
import 'ThemesScreen.dart';
import 'NotationScreen.dart';
import 'UserScalesScreen.dart';
import 'UserChordsScreen.dart';

class Home extends StatelessWidget {

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
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).iconTheme.color,
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
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: InkWell(
                  onTap:() {},
                  child: ListTile(
                    title: Text(
                      "MIDI",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).iconTheme.color,
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
                      MaterialPageRoute(builder: (context) => UserScalesScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "User Scales",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).iconTheme.color,
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
                      MaterialPageRoute(builder: (context) => UserChordsScreen()),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "User Chords",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).iconTheme.color,
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
                  MaterialPageRoute(builder: (context) => NotesScreen('Favourites')), // TODO: create page for favourites
                );
              },
              child: Container(
                height: 48.0,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Favourites',
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

/*
        actions: <Widget> [
          PopupMenuButton(
            onSelected: (value) {
              MusicTheory.toggleNoteRepresentation(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'solfeggio',
                  child: Text('Solfeggio notation'),
                ),
                PopupMenuItem(
                  value: 'alphabet',
                  child: Text('Alphabet notation'),
                ),
              ];
            },
          ),
        ]
* */