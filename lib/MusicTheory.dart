/*
The logic of the application. Takes a root note a finds all sorts of scales and
chords
*/
import 'dart:math';

class MusicTheory {

  static int interval_between_notes;
  static int note_duration;
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

  static void changeBpm(int bpm) {
    interval_between_notes = ((60/bpm)*1000).round();
  }

  static void changeNoteRepresentation(String note_representation) {
    if (note_representation == 'alphabet') {
      notes = alphabet_notes;
    } else if (note_representation == 'solfeggio') {
      notes = solfeggio_notes;
    }
  }

  /*
  *     MusicTheory.changeLegatoStaccato(legatoStaccato);
    MusicTheory.changeBpm(bpm);*/
  static void changeLegatoStaccato(String legato_staccato) {
    if (legato_staccato == 'legato') {
      note_duration = interval_between_notes;
    } else {
      note_duration = (interval_between_notes/2).round();
    }
  }

  static List<int> midi(String scale_or_chord) {
    List<int> midiNotes = [];
    scale_or_chord.split(' ').forEach((note) {
      midiNotes.add(60+notes.indexOf(note));
    });
    int indexMax = midiNotes.indexOf(midiNotes.reduce(max));
    for(int i=0; i<midiNotes.length; i+=1) {
      if(i > indexMax) {
        midiNotes[i] += 12;
      }
    }
    if(midiNotes[0]==midiNotes[midiNotes.length-1]){
      midiNotes[midiNotes.length-1] += 12;
    }
    return midiNotes;
  }

  static List<String> scales(String note) {
    int start = notes.indexOf(note);
    List<String> scales = List<String>();

    scales_map.forEach((key, value) {
      scales.add(note+" "+key);
      scales.add(__scaleRuleToNotes(start, note, value));
    });

    return scales;
  }

  static List<String> chords(String note) {
    int start = notes.indexOf(note);
    List<String> chords = List<String>();

    chords_map.forEach((key, value) {
      chords.add(note+" "+key);
      chords.add(__chordRuleToNotes(start, note, value));
    });

    return chords;
  }

  // helper method used in __semitonesRuleToNotes
  static int __semitonesRuleToIndex(String rule, int start) {
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

  static String __scaleRuleToNotes(int start, String note, String rule) {
    String scale = note;

    for(int i=0;i<rule.length;i++) {
      start = __semitonesRuleToIndex(rule[i], start);
      if(start == -1) return "";        // TODO: handle errors
      scale += ' ' + notes[start];
    }

    return scale;
  }

  static String __chordRuleToNotes(int start, String note, String rule) {
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