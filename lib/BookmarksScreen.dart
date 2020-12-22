import 'package:flutter/material.dart';
import 'LoadingScreen.dart';
import 'UserFile.dart';
import 'dart:async';
import 'dart:io';

/*
This screen shows the bookmarks saved by the user. Here the user can find both
scales and chords he decided to bookmark
*/

class BookmarksScreen extends StatefulWidget {
  UserFile file;
  String element;
  BookmarksScreen() {
    file = new UserFile('Bookmarks');
  }

  @override
  _BookmarksScreen createState() => _BookmarksScreen();
}

class _BookmarksScreen extends State<BookmarksScreen> {
  List<String> bookmarks;
  bool done = false;

  // reads elements from file
  @override
  void initState() {
    widget.file.read().then((List<String> value) {
      setState(() {
        bookmarks = [];
        if (value != null) {
          value.forEach((element) {
            bookmarks.add(element);
          });
        }
        done = true;
      });
    });
  }

  Future<File> removeElement(String name, String pattern) {
    setState(() {
      bookmarks.remove(name);
      bookmarks.remove(pattern);
    });

    return widget.file.remove(name);
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
              'Bookmarks',
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
                                'Add bookmarks in the',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                'scales or chord screens',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ]
                        ),
                      ],
                    )
                ),
              ),
            ),
            for(int i=0; i<this.bookmarks.length; i+=2)
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
                                  this.bookmarks[i],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  this.bookmarks[i+1],
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(Icons.bookmark),
                                tooltip: 'Delete',
                                onPressed: () {
                                  removeElement(this.bookmarks[i], this.bookmarks[i+1]);
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
