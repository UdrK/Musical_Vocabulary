import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'Home.dart';

class ThemesScreen extends StatefulWidget {
  @override
  _ThemesScreen createState() => _ThemesScreen();
}

class _ThemesScreen extends State<ThemesScreen> {

  String choosen_theme = 'dark';
  int font_size = 20;
  Color font_color = Colors.white;
  Color background_color = Colors.white;
  Color button_color = Colors.white;
  Color primary_color = Colors.white;


  ThemesScreen() {}

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
                if (whichColor == 'font')
                  setState(()=>font_color=color);
                else if (whichColor == 'background')
                  setState(()=>background_color=color);
                else if (whichColor == 'button')
                  setState(()=>button_color=color);
                else if (whichColor == 'primary')
                  setState(()=>primary_color=color);
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text(
            'Choose a theme',
            style: Theme.of(context).textTheme.headline5,
          )
      ),
      body: Column(
        children: <Widget>[
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Dark Theme',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'dark',
              groupValue: choosen_theme,
              onChanged: (String value) { setState(() { choosen_theme = value; }); },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Light Theme',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'light',
              groupValue: choosen_theme,
              onChanged: (String value) { setState(() { choosen_theme = value; }); },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: RadioListTile<String>(
              title: Text(
                'Custom Theme',
                style: Theme.of(context).textTheme.headline6,
              ),
              value: 'custom',
              groupValue: choosen_theme,
              onChanged: (String value) { setState(() { choosen_theme = value; }); },
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            title: Text(
              "Custom Theme Settings",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text(
                "Font size: $font_size",
                style: Theme.of(context).textTheme.headline5,
              ),
              onTap: _showFontSizeDialog,
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Font color ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(
                    Icons.circle,
                    color: font_color,
                  ),
                ],
              ),
              onTap: () { _showColorDialog('font'); },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Primary color ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(
                    Icons.circle,
                    color: primary_color,
                  ),
                ],
              ),
              onTap: () { _showColorDialog('primary'); },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Button color ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(
                    Icons.circle,
                    color: button_color,
                  ),
                ],
              ),
              onTap: () { _showColorDialog('button'); },
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Background color ",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Icon(
                    Icons.circle,
                    color: background_color,
                  ),
                ],
              ),
              onTap: () { _showColorDialog('background'); },
            ),
          ),
        ],
      ),
    );
  }
}

