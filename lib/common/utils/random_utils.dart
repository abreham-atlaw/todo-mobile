import 'dart:math';


class RandomUtils{

  static String generateRandomString(int length) {
    const _randomChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const _charsLength = _randomChars.length;

    final rand = Random();
    final codeUnits = List.generate(
        length,
            (index) {
          return _randomChars.codeUnitAt(
              rand.nextInt(_charsLength)
          );
        }
    );

    return String.fromCharCodes(codeUnits);
  }


}