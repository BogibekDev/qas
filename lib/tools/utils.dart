import 'dart:io';

class Utils {
  static bool isDesktop() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}

extension Price on double {
  String price() {
    var s = toString();
    s = s.substring(0, s.length - 2);
    var result = s[s.length - 1];
    for (int i = 1; i < s.length; i++) {
      if (i % 3 == 0) {
        result = "${s[s.length - i - 1]} $result";
      } else {
        result = s[s.length - i - 1] + result;
      }
    }
    return "$result UZS";
  }
}
