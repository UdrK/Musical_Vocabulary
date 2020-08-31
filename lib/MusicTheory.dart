import 'package:flutter/material.dart';

class MusicTheory {
  String note;
  static List<String> solfeggio_notes = ['Do', 'Do#', 'Re', 'Re#', 'Mi', 'Fa', 'Fa#', 'Sol', 'Sol#', 'La', 'La#', 'Si'];
  static List<String> alphabet_notes = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#'];
  static List<String> notes = alphabet_notes;

  MusicTheory(String note) {
    this.note = note;
  }

  static void toggleNoteRepresentation(String note_representation) {
    if (note_representation == 'alphabet') {
      notes = alphabet_notes;
    } else if (note_representation == 'solfeggio') {
      notes = solfeggio_notes;
    }
  }

  List<String> scales() {
    int start = notes.indexOf(note);
    List<String> scales = List<String>();

    scales.add(note+' Major Scale');
    scales.add(majorScale(start, note));

    scales.add(note+' Natural Minor Scale');
    scales.add(naturalMinorScale(start, note));

    scales.add(note+' Harmonic Minor Scale');
    scales.add(harmonicMinorScale(start, note));

    scales.add(note+' Melodic Minor Scale');
    scales.add(melodicMinorScale(start, note));

    scales.add(note+' Minor Pentatonic Scale');
    scales.add(minorPentatonicScale(start, note));

    scales.add(note+' Pentatonic Blues Scale');
    scales.add(pentatonicBluesScale(start, note));

    scales.add(note+' Mixolydian Scale');
    scales.add(mixolydianScale(start, note));

    return scales;
  }

  List<String> chords() {
    int start = notes.indexOf(note);
    List<String> chords = List<String>();

    chords.add(note+' Major Triad');
    chords.add(majorTriad(start, note));

    chords.add(note+' Major Sixth Chord');
    chords.add(majorSixthChord(start, note));

    chords.add(note+' Dominant Seventh Chord');
    chords.add(dominantSeventhChord(start, note));

    chords.add(note+' Major Seventh Chord');
    chords.add(majorSeventhChord(start, note));

    chords.add(note+' Augmented Triad');
    chords.add(augmentedTriad(start, note));

    chords.add(note+' Minor Triad');
    chords.add(minorTriad(start, note));

    chords.add(note+' Minor Sixth Chord');
    chords.add(minorSixthChord(start, note));

    chords.add(note+' Minor Seventh Chord');
    chords.add(minorSeventhChord(start, note));

    chords.add(note+' Minor-Major Seventh Chord');
    chords.add(seventhChord(start, note));

    chords.add(note+' Diminished Triad');
    chords.add(diminishedTriad(start, note));

    chords.add(note+' Diminished Seventh Chord');
    chords.add(diminishedSeventhChord(start, note));

    chords.add(note+' Half-Diminished Seventh Chord');
    chords.add(halfDiminishedSeventhChord(start, note));

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

  String majorScale(int start, String note) {
    // W-W-H-W-W-W
    String rule = "WWHWWWH";
    return __scaleRuleToNotes(start, note, rule);
  }

  String naturalMinorScale(int start, String note) {
    // W-H-W-W-H-W-W
    String rule = "WHWWHWW";
    return __scaleRuleToNotes(start, note, rule);
  }

  String harmonicMinorScale(int start, String note) {
    // W-H-W-W-H-m-H
    String rule = "WHWWHmH";
    return __scaleRuleToNotes(start, note, rule);
  }

  String melodicMinorScale(int start, String note) {
    // W-H-W-W-W-W-H
    String rule = "WHWWWWH";
    return __scaleRuleToNotes(start, note, rule);
  }

  String minorPentatonicScale(int start, String note) {
    // m-W-W-m-W
    String rule = "mWWmW";
    return __scaleRuleToNotes(start, note, rule);
  }

  String pentatonicBluesScale(int start, String note) {
    // m-W-H-H-W
    String rule = "mWHHW";
    return __scaleRuleToNotes(start, note, rule);
  }

  String mixolydianScale(int start, String note) {
    // W-W-H-W-W-H-W
    String rule = "WWHWWHW";
    return __scaleRuleToNotes(start, note, rule);
  }

  String majorTriad(int start, String note) {
    String rule = "MP";
    return __chordRuleToNotes(start, note, rule);
  }

  String majorSixthChord(int start, String note) {
    String rule = "MPD";
    return __chordRuleToNotes(start, note, rule);
  }

  String dominantSeventhChord(int start, String note) {
    String rule = "MPs";
    return __chordRuleToNotes(start, note, rule);
  }

  String majorSeventhChord(int start, String note) {
    String rule = "MPS";
    return __chordRuleToNotes(start, note, rule);
  }

  String augmentedTriad(int start, String note) {
    String rule = "MA";
    return __chordRuleToNotes(start, note, rule);
  }

  String augmentedSeventhChord(int start, String note) {
    String rule = "MAs";
    return __chordRuleToNotes(start, note, rule);
  }

  String minorTriad(int start, String note) {
    String rule = "mP";
    return __chordRuleToNotes(start, note, rule);
  }

  String minorSixthChord(int start, String note) {
    String rule = "mPD";
    return __chordRuleToNotes(start, note, rule);
  }

  String minorSeventhChord(int start, String note) {
    String rule = "mPs";
    return __chordRuleToNotes(start, note, rule);
  }

  String seventhChord(int start, String note) {
    String rule = "mPS";
    return __chordRuleToNotes(start, note, rule);
  }

  String diminishedTriad(int start, String note) {
    String rule = "md";
    return __chordRuleToNotes(start, note, rule);
  }

  String diminishedSeventhChord(int start, String note) {
    String rule = "mdD";
    return __chordRuleToNotes(start, note, rule);
  }

  String halfDiminishedSeventhChord(int start, String note) {
    String rule = "mds";
    return __chordRuleToNotes(start, note, rule);
  }

}