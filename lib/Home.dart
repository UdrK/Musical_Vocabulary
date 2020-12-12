import 'package:flutter/material.dart';
import 'NotesScreen.dart';

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
              ListTile(
                title: Text("Font"),
                trailing: Icon(Icons.arrow_forward),
                tileColor: Theme.of(context).cardColor,
              ),
              ListTile(
                title: Text("Themes"),
                trailing: Icon(Icons.arrow_forward),
                tileColor: Theme.of(context).cardColor,
              ),
              ListTile(
                title: Text("Notation"),
                trailing: Icon(Icons.arrow_forward),
                tileColor: Theme.of(context).cardColor,
              ),
              ListTile(
                title: Text("MIDI"),
                trailing: Icon(Icons.arrow_forward),
                tileColor: Theme.of(context).cardColor,
              ),
              ListTile(
                title: Text("+  Add Custom Scales"),
                trailing: Icon(Icons.arrow_forward),
                tileColor: Theme.of(context).cardColor,
              ),
              ListTile(
                title: Text("+  Add Custom Chords"),
                trailing: Icon(Icons.arrow_forward),
                tileColor: Theme.of(context).cardColor,
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