import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoadingScreen.dart';

/*
This screen lets the user pick a theme and make a custom one
*/


class ThemesScreen extends StatefulWidget {
  @override
  _ThemesScreen createState() => _ThemesScreen();
}

class _ThemesScreen extends State<ThemesScreen> {
  String choosen_theme;
  int font_size = 20;
  Color font_color = Colors.white;
  Color background_color = Colors.white;
  Color button_color = Colors.white;
  Color primary_color = Colors.white;

  bool done = false;

  Future<bool> loadSettings() async {
    await SharedPreferences.getInstance().then((value) { choosen_theme = value.getString('default_theme');});
    await SharedPreferences.getInstance().then((value) { font_size = value.getInt('custom_font_size');});
    await SharedPreferences.getInstance().then((value) { font_color = Color(value.getInt('custom_font_color'));});
    await SharedPreferences.getInstance().then((value) { background_color = Color(value.getInt('custom_background'));});
    await SharedPreferences.getInstance().then((value) { button_color = Color(value.getInt('custom_card'));});
    await SharedPreferences.getInstance().then((value) { primary_color = Color(value.getInt('custom_primary'));});
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

  void _showFontSizeDialog() {
    showDialog<int>(
      barrierColor: Theme.of(context).backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          initialIntegerValue: font_size,
          minValue: 10,
          maxValue: 30,
          title: new Text("Pick a new font size"),
        );
      }
    ).then((int value) {
      if (value != null) {
        setState(() => font_size = value);
        final prefs = SharedPreferences.getInstance();
        prefs.then((value) => value.setInt('custom_font_size', font_size));
      }
    });
  }

  void _showColorDialog(String whichColor) {
    showDialog(
      barrierColor: Theme.of(context).backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: primary_color,
              onColorChanged: (Color color) {
                if (whichColor == 'font') {
                  setState(() => font_color = color);
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setInt('custom_font_color', font_color.value));
                }
                else if (whichColor == 'background') {
                  setState(() => background_color = color);
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setInt('custom_background', background_color.value));
                }
                else if (whichColor == 'button') {
                  setState(() => button_color = color);
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setInt('custom_card', button_color.value));
                }
                else if (whichColor == 'primary') {
                  setState(() => primary_color = color);
                  final prefs = SharedPreferences.getInstance();
                  prefs.then((value) => value.setInt('custom_primary', primary_color.value));
                }
              },
              enableLabel: true,
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (done == false) {
      return MaterialApp(
        home: LoadingScreen(),
      );
    }
    else {
      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: AppBar(
            title: Text(
              'Choose a theme',
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
              child: RadioListTile<String>(
                title: Text(
                  'Dark Theme',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                value: 'dark',
                groupValue: choosen_theme,
                onChanged: (String value) {
                  setState(() {
                    choosen_theme = value;
                    final prefs = SharedPreferences.getInstance();
                    prefs.then((value) =>
                        value.setString('default_theme', 'dark'));
                  });
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: RadioListTile<String>(
                title: Text(
                  'Light Theme',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                value: 'light',
                groupValue: choosen_theme,
                onChanged: (String value) {
                  setState(() {
                    choosen_theme = value;
                    final prefs = SharedPreferences.getInstance();
                    prefs.then((value) =>
                        value.setString('default_theme', 'light'));
                  });
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: RadioListTile<String>(
                title: Text(
                  'Custom Theme',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                value: 'custom',
                groupValue: choosen_theme,
                onChanged: (String value) {
                  setState(() {
                    choosen_theme = value;
                    final prefs = SharedPreferences.getInstance();
                    prefs.then((value) {
                      value.setString('default_theme', 'custom');
                      value.setInt('custom_primary', primary_color.value);
                      value.setInt('custom_card', button_color.value);
                      value.setInt('custom_background', background_color.value);
                      value.setInt('custom_font_color', font_color.value);
                      value.setInt('custom_font_size', font_size);
                    });
                  });
                },
              ),
            ),
            ListTile(
              tileColor: Theme
                  .of(context)
                  .cardColor,
              title: Text(
                "Theme changes apply after restart",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              tileColor: Theme
                  .of(context)
                  .primaryColor,
              title: Text(
                "Custom Theme Settings",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Text(
                  "Font size: $font_size",
                  style: Theme.of(context).textTheme.headline6,
                ),
                onTap: _showFontSizeDialog,
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      "Font color: ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)
                      ),
                      child: Icon(
                        Icons.circle,
                        color: font_color,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  _showColorDialog('font');
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      "Primary color: ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)
                      ),
                      child: Icon(
                        Icons.circle,
                        color: primary_color,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  _showColorDialog('primary');
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      "Button color: ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)
                      ),
                      child: Icon(
                        Icons.circle,
                        color: button_color,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  _showColorDialog('button');
                },
              ),
            ),
            Material(
              color: Theme
                  .of(context)
                  .cardColor,
              child: ListTile(
                title: Row(
                  children: [
                    Text(
                      "Background color: ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black)
                      ),
                      child: Icon(
                        Icons.circle,
                        color: background_color,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  _showColorDialog('background');
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}

