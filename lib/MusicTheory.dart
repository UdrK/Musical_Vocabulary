import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutter/services.dart';

class MusicTheory {
  String note;

  static List<String> solfeggio_notes = ['Do', 'Do#', 'Re', 'Re#', 'Mi', 'Fa', 'Fa#', 'Sol', 'Sol#', 'La', 'La#', 'Si'];
  static List<String> alphabet_notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
  static List<String> notes = alphabet_notes;

  static var chords_map = <String, String> {
    "Major Triad": "MP",
    "Major Sixth": "MPD",
    "Dominant Seventh": "MPs",
    "Major Seventh": "MPS",
    "Augmented Triad": "MA",
    "Augmented Seventh": "MAs",
    "Minor Triad": "mP",
    "Minor Sixth": "mPD",
    "Minor Seventh": "mPs",
    "Seventh": "mPS",
    "Diminished Triad": "md",
    "Diminished Seventh": "mdD",
    "Half-Diminished Seventh": "mds",
  };

  static var scales_map = <String, String> {
    "Major": "WWHWWWH",
    "Natural Minor": "WHWWHWW",
    "Harmonic Minor": "WHWWHmH",
    "Melodic Minor": "WHWWWWH",
    "Minor Pentatonic": "mWWmW",
    "Pentatonic Blues": "mWHHW",
    "Mixolydian": "WWHWWHW",
  };

  MusicTheory(String note) {
    this.note = note;
  }

  static void changeNoteRepresentation(String note_representation) {
    if (note_representation == 'alphabet') {
      notes = alphabet_notes;
    } else if (note_representation == 'solfeggio') {
      notes = solfeggio_notes;
    }
  }

  static void play(String element) async {
    List<int> midiNotes = [];
    element.split(' ').forEach((note) {
      midiNotes.add(60+notes.indexOf(note));
    });

    FlutterMidi midiPlayer = new FlutterMidi();
    midiPlayer.unmute();
    await rootBundle.load("assets/soundfonts/Plastic_Strings.sf2").then((sf2) {
      midiPlayer.prepare(sf2: sf2, name: "Plastic_Strings.sf2");
    });

    midiNotes.forEach((note) {
      midiPlayer.playMidiNote(midi: note);

      Future.delayed(Duration(milliseconds: 300),
              () =>  midiPlayer.stopMidiNote(midi: note));
    });
  }

  List<String> scales() {
    int start = notes.indexOf(note);
    List<String> scales = List<String>();

    scales_map.forEach((key, value) {
      scales.add(note+" "+key);
      scales.add(__scaleRuleToNotes(start, note, value));
    });

    return scales;
  }

  List<String> chords() {
    int start = notes.indexOf(note);
    List<String> chords = List<String>();

    chords_map.forEach((key, value) {
      chords.add(note+" "+key);
      chords.add(__chordRuleToNotes(start, note, value));
    });

    return chords;
  }

  // helper method used in __semitonesRuleToNotes
  int __semitonesRuleToIndex(String rule, int start) {
    int semitones;
    // 1 semitone
    if (rule == 'H') {
      semitones = 1;
    }
    // 2 semitones: major second
    else if (rule == 'W') {
      semitones = 2;
    }
    // 3 semitones: minor third
    else if (rule == 'm') {
      semitones = 3;
    }
    // 4 semitones: major third
    else if (rule == 'M') {
      semitones = 4;
    }
    // 5 semitones: perfect fourth
    else if (rule == 'p') {
      semitones = 5;
    }
    // 6 semitones: tritone
    else if (rule == 'd') {
      semitones = 6;
    }
    // 7 semitones: perfect fifth
    else if (rule == 'P') {
      semitones = 7;
    }
    // 8 semitones: augmented fifth
    else if (rule == 'A') {
      semitones = 8;
    }
    // 9 semitones: major sixth / diminished seventh
    else if (rule == 'D') {
      semitones = 9;
    }
    // 10 semitones: minor seventh
    else if (rule == 's') {
      semitones = 10;
    }
    // 11 semitones: major seventh
    else if (rule == 'S') {
      semitones = 11;
    }
    // else error
    else return -1;

  int index = -1;
  for(int i=0; i<semitones; i++) {
    if(start+semitones == notes.length+i)
      index = i;
  }

  if(index == -1) {
    index = start + semitones;
  }

  return index;

  }

  String __scaleRuleToNotes(int start, String note, String rule) {
    String scale = note;

    for(int i=0;i<rule.length;i++) {
      start = __semitonesRuleToIndex(rule[i], start);
      if(start == -1) return "";        // TODO: handle errors
      scale += ' ' + notes[start];
    }

    return scale;
  }

  String __chordRuleToNotes(int start, String note, String rule) {
    String scale = note;
    int index;
    for(int i=0;i<rule.length;i++) {
      index = __semitonesRuleToIndex(rule[i], start);
      if(start == -1) return "";        // TODO: handle errors
      scale += ' ' + notes[index];
    }

    return scale;
  }

}