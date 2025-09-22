import 'dart:ui';

class Zikr {
  final String text;
  final String translation;
  final int count;
  final int colorValue;

  Zikr({
    required this.text,
    required this.translation,
    required this.count,
    required this.colorValue,
  });

  Color get color => Color(colorValue);

  @override
  String toString() {
    return 'Zikr{text: $text, translation: $translation, count: $count}';
  }
}

final List<Zikr> zikrList = [
  Zikr(
    text: "سُبْحَانَ اللَّهِ",
    translation: "Glory be to Allah",
    count: 33,
    colorValue: 0xFF4CA1AF,
  ),
  Zikr(
    text: "الْحَمْدُ لِلَّهِ",
    translation: "Praise be to Allah",
    count: 33,
    colorValue: 0xFF2AA5A1,
  ),
  Zikr(
    text: "اللَّهُ أَكْبَرُ",
    translation: "Allah is the Greatest",
    count: 34,
    colorValue: 0xFF9B59B6,
  ),
  Zikr(
    text: "لَا إِلٰهَ إِلَّا اللَّهُ",
    translation: "There is no god but Allah",
    count: 33,
    colorValue: 0xFFE74C3C,
  ),
];