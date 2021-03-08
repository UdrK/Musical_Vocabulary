import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';
import 'MusicTheory.dart';
import 'LoadingScreen.dart';

/*
App entry point, here settings are loaded (a loading screen is eventually shown)
and the home screen is started
*/

void main() {
  runApp(MusicalVocabulary());
}

void setDefaultSettings() async {
  final prefs = await SharedPreferences.getInstance();
  //await prefs.clear();
  int theme = prefs.getInt('bpm');
  if (theme == null) {
    print("i do this");
    prefs.setString('default_theme', 'light');
    prefs.setInt('dark_primary', Colors.blueGrey[700].value);
    prefs.setInt('dark_card', Colors.blueGrey[800].value);
    prefs.setInt('dark_background', Colors.blueGrey[900].value);
    prefs.setInt('dark_font_color', Colors.white.value);
    prefs.setInt('dark_font_size', 20);
    prefs.setInt('light_primary', Colors.grey[200].value);
    prefs.setInt('light_card', Colors.grey[400].value);
    prefs.setInt('light_background', Colors.grey[600].value);
    prefs.setInt('light_font_color', Colors.black.value);
    prefs.setInt('light_font_size', 20);
    prefs.setInt('custom_primary', Colors.white.value);
    prefs.setInt('custom_card', Colors.white.value);
    prefs.setInt('custom_background', Colors.white.value);
    prefs.setInt('custom_font_color', Colors.black.value);
    prefs.setInt('custom_font_size', 20);
    prefs.setString('notation', 'alphabet');
    prefs.setString('legatoStaccato', 'staccato');
    prefs.setInt('bpm', 60);
    prefs.setBool('skip_intro', false);
    prefs.setBool('scales_q', true);
    prefs.setBool('chords_q', true);
    prefs.setBool('sharp_q', true);
    prefs.setInt('scales_quizzes', 0);
    prefs.setInt('chords_quizzes', 0);
    prefs.setInt('correct_scales', 0);
    prefs.setInt('correct_chords', 0);
  }
}

Future<int> getDefaultSetting(setting) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('default_theme') == 'dark') {
    return prefs.getInt('dark_'+setting);
  } else if (prefs.getString('default_theme') == 'light') {
    return prefs.getInt('light_'+setting);
  } else if (prefs.getString('default_theme') == 'custom') {
    return prefs.getInt('custom_'+setting);
  } else throw new FormatException("Wrong default theme");
}

class MusicalVocabulary extends StatefulWidget {
  @override
  _MusicalVocabulary createState() => _MusicalVocabulary();
}

class _MusicalVocabulary extends State<MusicalVocabulary> {
  String theme;
  static Color primary_color;
  static Color card_color;
  static Color background_color;
  static Color font_color;
  static int font_size;
  bool skip_intro;
  bool done = false;
  String notation;
  String legatoStaccato;
  int bpm;

  Future<bool> loadSettings() async {
    await setDefaultSettings();
    final prefs = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance().then((value) { theme = value.getString('default_theme');});
    await SharedPreferences.getInstance().then((value) { notation = value.getString('notation');});
    await SharedPreferences.getInstance().then((value) { legatoStaccato = value.getString('legatoStaccato');});
    await SharedPreferences.getInstance().then((value) { bpm = value.getInt('bpm');});
    await SharedPreferences.getInstance().then((value) { skip_intro = value.getBool('skip_intro');});
    await prefs.setBool('skip_intro', true);

    MusicTheory.changeNoteRepresentation(notation);
    MusicTheory.changeBpm(bpm);
    MusicTheory.changeLegatoStaccato(legatoStaccato);

    primary_color = Color(await getDefaultSetting('primary'));
    card_color = Color(await getDefaultSetting('card'));
    background_color = Color(await getDefaultSetting('background'));
    font_color = Color(await getDefaultSetting('font_color'));
    font_size = await getDefaultSetting('font_size');
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
  Widget build(BuildContext context) {
    if (done == false) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      );
    }
    else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primary_color,
          // app bar color
          cardColor: card_color,
          // cards or tiles color
          backgroundColor: background_color,
          // background
          iconTheme: IconThemeData(
            color: font_color,
          ),
          textTheme: TextTheme(
            headline6: TextStyle( // notes
              fontSize: font_size + .0,
              fontWeight: FontWeight.w300,
              color: font_color,
            ),
            headline5: TextStyle( // titles
              fontSize: font_size + 4.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: font_color,
            ),
            headline4: TextStyle( // names
              fontSize: font_size + .0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: font_color,
            ),
          ),
        ),
        home: (skip_intro) ? HomeScreen() : Carousel(),
      );
    }
  }
}
