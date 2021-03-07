import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Learn scales and chords",
          body:
          "Instead of their shape, learn what notes they're made of.",
          image: _buildImage('img1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Easy to use",
          body:
          "Choose between scales and chord, a root note, and you're done.",
          image: _buildImage('img2.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Add more",
          body:
          "Add your own scales and chords by simply inserting the intervals.",
          image: _buildImage('img2.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bookmark your favorites",
          body: "You'll be able to access them even faster.",
          image: _buildImage('img2.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Test enhanced learning",
          body: "Learn quicker by quizzing yourself.",
          image: _buildImage('img2.gif'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
