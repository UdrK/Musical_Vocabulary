import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class UserFile {

  String filename;
  UserFile(String filename) {
    this.filename = 'User_'+filename+'.txt';
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/'+filename);
  }

  Future<List<String>> read() async {
    try {
      final file = await _localFile;
      String file_content = await file.readAsString();
      List<String> chords = file_content.split('\n');
      if (chords.isNotEmpty)
        chords.removeLast();
      return chords;
    } catch (e) {}
  }

  Future<File> write(String name, String pattern) async {
    final file = await _localFile;
    await file.writeAsString('$name\n$pattern\n', mode: FileMode.append);
    return file;
  }

  Future<File> remove(String name) async {
    List<String> chords = await read();
    final file = await _localFile;
    await file.writeAsString('', mode: FileMode.write); //clears file
    int i = 0;
    for (i=0; i<chords.length; i+=2) {
      if(name != chords[i]) {                   // writes every other chord
        await write(chords[i], chords[i+1]);
      }
    }
    return file;
  }
}
