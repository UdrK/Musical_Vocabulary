import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'HomeScreen.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  static double titleFontSize = 28;
  final pages = [
    PageViewModel(
        pageColor: Colors.grey,
        // iconImageAssetPath: 'assets/air-hostess.png',
        body: Text(
          "Instead of their shape, learn what notes they're made of.",
        ),
        title: Text(
          'Learn scales and chords',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black, fontSize: titleFontSize),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
        mainImage: Image.asset(
          'assets/images/img1.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: Colors.grey,
        // iconImageAssetPath: 'assets/air-hostess.png',
        body: Text(
          "Choose between scales and chord, a root note, and you're done.",
        ),
        title: Text(
          'Easy to use',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black, fontSize: titleFontSize),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
        mainImage: Image.asset(
          'assets/images/img2.gif',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
        pageColor: Colors.grey,
        body: Text(
          'Add your own scales and chords by simply inserting the intervals.',
        ),
        title: Text(
          'Add more',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black, fontSize: titleFontSize),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
        mainImage: Image.asset(
          'assets/images/img3.gif',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.grey,
      body: Text(
        "You'll be able to access them even faster.",
      ),
      title: Text('Bookmark your favorites'),
      mainImage: Image.asset(
        'assets/images/img4.gif',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black, fontSize: titleFontSize),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
    ),
    PageViewModel(
      pageColor: Colors.grey,
      body: Text(
        'Learn quicker by quizzing yourself.',
      ),
      title: Text('Test enhanced learning'),
      mainImage: Image.asset(
        'assets/images/img5.gif',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black, fontSize: titleFontSize),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      showSkipButton: true,
      showNextButton: false,
      showBackButton: false,
      onTapSkipButton: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      },
      onTapDoneButton: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      },
      fullTransition: 150,
      pageButtonTextStyles: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
    ); //Material App
  }
}
