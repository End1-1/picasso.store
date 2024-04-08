import 'dart:convert';
import 'dart:typed_data';

class Res {
  static Map<String, Uint8List> images = {};
  static void initFrom(String s) {
    List<dynamic> sd = jsonDecode(s);
    for (final e in sd) {
      for (final k in e.keys) {
        images[k] = base64Decode(e[k]);
      }
    }
  }
}