import 'package:html/parser.dart';

class Helper {

  static final String? networkError = "NetworkError";

  static String parseHtmlString(String? htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text.toString()).documentElement!.text.toString();
    return parsedString;
  }

}