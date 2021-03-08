import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoadingScreen.dart';
import 'MusicTheory.dart';

/*
This screen shows the user either a list of Scales or Chords depending on what
the user selected in the home screen
*/

class QuizScreen extends StatefulWidget {

  //QuizScreen() {}

  @override
  _QuizScreen createState() => _QuizScreen();
}

class _QuizScreen extends State<QuizScreen> {

  //_QuizScreen() {}
  int indexTapped=-1;
  int winningIndex=-1;
  bool tapped = false;
  bool scales;
  bool chords;
  bool sharp;
  bool done = false;
  String toBeGuessed;
  String toBeGuessedName;
  String post_fixed;
  List<String> final_options;

  Future<bool> load() async {
    await SharedPreferences.getInstance().then((value) { scales = value.getBool('scales_q');});
    await SharedPreferences.getInstance().then((value) { chords = value.getBool('chords_q');});
    await SharedPreferences.getInstance().then((value) { sharp = value.getBool('sharp_q');});
    return true;
  }

  @override
  void initState() {
    load().then((value) {
      setState(() {
        getQuiz();
        done = value;
      });
    });
  }

  void getQuiz() {
    String root_note;
    if (!sharp) {
      List<String> notSharpNotes = []..addAll(MusicTheory.notes);
      notSharpNotes.removeWhere((element) => element.contains("#"));
      root_note = notSharpNotes[Random().nextInt(notSharpNotes.length)];
    } else {
      root_note = MusicTheory.notes[Random().nextInt(MusicTheory.notes.length)];
    }
    int choice = -1;
    List<String> all_options = new List<String>();
    if (scales && chords) {
      choice = Random().nextInt(2);
    }

    if (choice == 0 || (scales && !chords)) {
      post_fixed = "Scale";
      all_options = MusicTheory.scales(root_note);
    } else if (choice == 1 || (!scales && chords)) {
      post_fixed = "Chord";
      all_options = MusicTheory.chords(root_note);
    }
    int toBeGuessedIndex = Random().nextInt(all_options.length);
    if (toBeGuessedIndex%2==0) {
      toBeGuessedName = all_options[toBeGuessedIndex];
      toBeGuessed = all_options[toBeGuessedIndex+1];
      all_options.removeAt(toBeGuessedIndex+1);
      all_options.removeAt(toBeGuessedIndex);
    } else {
      toBeGuessedName = all_options[toBeGuessedIndex-1];
      toBeGuessed = all_options[toBeGuessedIndex];
      all_options.removeAt(toBeGuessedIndex);
      all_options.removeAt(toBeGuessedIndex-1);
    }

    List<String> aux_options = []..addAll(all_options);
    all_options.clear();
    for(int i=0; i<aux_options.length; i+=1) {
      if (i%2 != 0)
        all_options.add(aux_options[i]);
    }

    final_options = new List<String>();
    for (int i=0; i<3; i+=1) {
      int index = Random().nextInt(all_options.length);
      String temp = all_options[index];
      all_options.removeAt(index);
      final_options.add(temp);
    }
    final_options.add(toBeGuessed);
    final_options.shuffle();
    winningIndex = final_options.indexOf(toBeGuessed);
  }

  void updateStats(bool correct) async {
    int update = 0;
    if (correct) {
      update = 1;
    }
    final prefs = await SharedPreferences.getInstance();
    int scales_quizzes, chords_quizzes, correct_scales, correct_chords;
    if (post_fixed == "Scale") {
      scales_quizzes = prefs.getInt('scales_quizzes');
      correct_scales = prefs.getInt('correct_scales');
      scales_quizzes += 1;
      correct_scales += update;
      prefs.setInt('scales_quizzes', scales_quizzes);
      prefs.setInt('correct_scales', correct_scales);
    } else {
      chords_quizzes = prefs.getInt('chords_quizzes');
      correct_chords = prefs.getInt('correct_chords');
      chords_quizzes += 1;
      correct_chords += update;
      prefs.setInt('chords_quizzes', chords_quizzes);
      prefs.setInt('correct_chords', correct_chords);
    }
  }


  @override
  Widget build(BuildContext context) {
    if (!done) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      );
    } else {
      if (!scales && !chords) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
              title: Text(
                'Quiz',
                style: Theme.of(context).textTheme.headline5,
              )
          ),
            body: Center(
                child: Material(
                  color: Theme.of(context).backgroundColor,
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline6,
                        children: [
                          TextSpan(text: "Decide whether you want to be quizzed on scales or chords or both in the quiz settings"),
                        ],
                      )
                  ),
                ))
        );
      } else {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
              title: Text(
                'Quiz',
                style: Theme.of(context).textTheme.headline5,
              )
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).cardColor,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
            label: Text(
              'Next',
              style: Theme.of(context).textTheme.headline6,
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
                child: Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.headline6,
                        children: [
                          TextSpan(text: "Which of the following is the $toBeGuessedName $post_fixed ?"),
                        ],
                      )
                  ),
                ),
              ),
              for(int i=0; i<this.final_options.length; i+=1)
                Material(
                  color: (!tapped) ? Theme.of(context).cardColor : (i==winningIndex) ? Colors.green : (i==indexTapped) ? Colors.red : Theme.of(context).cardColor,
                  child: InkWell(
                    child: Container(
                        height: 48.0,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          this.final_options[i],
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 2,
                        ),
                    ),
                    onTap: () {
                      if (!tapped) {
                        this.setState(() {
                          tapped = true;
                          indexTapped = i;
                        });
                        if (this.final_options[i] == toBeGuessed) {
                          updateStats(true);
                        } else {
                          updateStats(false);
                        }
                      }
                    },
                  ),
                ),
            ],
          ),
        );
      }
    }
  }
}