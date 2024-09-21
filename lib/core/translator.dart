import 'package:translator/translator.dart';

Future<String> translate(String text, {bool needsTranslate = true}) async {
  final translator = GoogleTranslator();
  if (!needsTranslate) {
    return text;
  }
  final res = await translator.translate(
    text,
    from: 'en',
    to: 'ru',
  );
  return res.text;
}
