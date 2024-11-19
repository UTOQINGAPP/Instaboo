
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf_text/pdf_text.dart';

class StringHelper {
  /// Returns the text inside the quotes or null if there is no match
  static String? extractTextWithinQuotes(String input) {
  RegExp regExp = RegExp(r'"(.*?)"');
  Match? match = regExp.firstMatch(input);

  return match?.group(1); 
}
static String getFileNameFromPath(String path) {
  return path.split(r'\').last;
}
static String getDirectoryPath(String path) {
  int lastSeparatorIndex = path.lastIndexOf(r'\');
  return path.substring(0, lastSeparatorIndex);
}

}