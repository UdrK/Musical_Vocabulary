import 'package:flutter/material.dart';
import 'LoadingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
This screen lets the user decide if the notes will be displayed in
solfeggio notation: Do, Re, Mi, ...
or
alphabet notation: C, D, E, ...
*/

class QuizSettingsScreen extends StatefulWidget {
  @override
  _QuizSettingsScreen createState() => _QuizSettingsScreen();
}

class _QuizSettingsScreen extends State<QuizSettingsScreen> {
  bool scales_q, chords_q, sharp_q;
  int scales_quizzes, chords_quizzes, correct_scales, correct_chords;
  int total_quizzes, total_correct;

  bool done = false;

  Future<bool> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    scales_q = prefs.getBool('scales_q');
    chords_q = prefs.getBool('chords_q');
    sharp_q = prefs.getBool('sharp_q');
    scales_quizzes = prefs.getInt('scales_quizzes');
    chords_quizzes = prefs.getInt('chords_quizzes');
    correct_scales = prefs.getInt('correct_scales');
    correct_chords = prefs.getInt('correct_chords');
    total_quizzes = scales_quizzes + chords_quizzes;
    total_correct = correct_scales + correct_chords;
    return true;
  }

  @override
  void initState() {
    loadSettings().then((value) {
      setState(() {
        done = value;
      });
    });
  }

  @override
  State<StatefulWidget> createState() {}

  @override
  Widget build(BuildContext context) {
    if (done == false) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      );
    } else {
      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: AppBar(
            title: Text(
              'Quiz Settings',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            )
        ),
        body: Column(
          children: <Widget>[
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: CheckboxListTile(
                title: Text(
                  'Quiz on scales',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                value: scales_q,
                onChanged: (bool user_value) {
                  setState(() {
                    scales_q = user_value;
                    final prefs = SharedPreferences.getInstance();
                    prefs.then((value) =>
                        value.setBool('scales_q', user_value));
                    //MusicTheory.changeNoteRepresentation(quiz_scales_or_chords);
                  });
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: CheckboxListTile(
                title: Text(
                  'Quiz on chords',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                value: chords_q,
                onChanged: (bool user_value) {
                  setState(() {
                    chords_q = user_value;
                    final prefs = SharedPreferences.getInstance();
                    prefs.then((value) =>
                        value.setBool('chords_q', user_value));
                    //MusicTheory.changeNoteRepresentation(quiz_scales_or_chords);
                  });
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: CheckboxListTile(
                title: Text(
                  'Quiz on scales or chords with sharp roots',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                value: sharp_q,
                onChanged: (bool user_value) {
                  setState(() {
                    sharp_q = user_value;
                    final prefs = SharedPreferences.getInstance();
                    prefs.then((value) => value.setBool('sharp_q', user_value));
                    //MusicTheory.changeNoteRepresentation(quiz_scales_or_chords);
                  });
                },
              ),
            ),
            ListTile(
              tileColor: Theme
                  .of(context)
                  .primaryColor,
              title: Text(
                "Statistics",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Quizzes taken: $total_quizzes",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Quizzes answered correctly: $total_correct",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Quizzes taken on scales: $scales_quizzes",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Scales guessed correctly: $correct_scales",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Quizzes taken on chords: $chords_quizzes",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Chords guessed correctly: $correct_chords",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

