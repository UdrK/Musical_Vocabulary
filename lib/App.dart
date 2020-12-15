import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musical_vocabulary/LoadingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';

void main() {
  runApp(App());
}

void setDefaultSettings() async {
  final prefs = await SharedPreferences.getInstance();
  //prefs.remove('default_theme');
  String theme = prefs.getString('default_theme');
  if (theme == null) {
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

class App extends StatefulWidget {

  @override
  _App createState() => _App();

}

class _App extends State<App> {

  String theme;
  Color primary_color;
  Color card_color;
  Color background_color;
  Color font_color;
  int font_size;
  bool done = false;

  Future<bool> loadSettings() async {
    await setDefaultSettings();
    await SharedPreferences.getInstance().then((value) { theme = value.getString('default_theme');});
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
        home: LoadingScreen(),
      );
    }
    else {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: primary_color,   // app bar color
          cardColor: card_color,      // cards or tiles color
          backgroundColor: background_color,  // background
          iconTheme: IconThemeData(
            color: font_color,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(     // notes
              fontSize: font_size+.0,
              fontWeight: FontWeight.w300,
              color: font_color,
            ),
            headline5: TextStyle(     // titles
              fontSize: font_size+4.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: font_color,
            ),
            headline4: TextStyle(     // names
              fontSize: font_size+.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: font_color,
            ),
          ),
        ),
        home: Home(),
      );
    }
  }
}


