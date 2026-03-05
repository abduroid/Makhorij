import 'package:makhorij_app/models/lesson.dart';
import 'package:makhorij_app/models/word.dart';

final lessons = [
  // Alif
  Lesson(
    letter: 'ا',
    audioAssetPath: 'assets/Alif.m4a',
    words: [
      Word(arabicText: "أَ", startMilliSeconds: 1000, endMilliSeconds: 2000),
      Word(arabicText: "إِ", startMilliSeconds: 3000, endMilliSeconds: 5000),
      Word(arabicText: "أُ", startMilliSeconds: 5000, endMilliSeconds: 7000),
      Word(arabicText: "أَءْ", startMilliSeconds: 8000, endMilliSeconds: 10000),
      Word(arabicText: "إِءْ", startMilliSeconds: 11000, endMilliSeconds: 12000),
      Word(arabicText: "أُءْ", startMilliSeconds: 14000, endMilliSeconds: 15000),
    ],
  ),
  // Lam
  Lesson(
    letter: 'ل',
    audioAssetPath: 'assets/Lam.m4a',
    words: [
      Word(arabicText: "لَ", startMilliSeconds: 0, endMilliSeconds: 2000),
      Word(arabicText: "لِ", startMilliSeconds: 2000, endMilliSeconds: 5000),
      Word(arabicText: "لُ", startMilliSeconds: 5000, endMilliSeconds: 7000),
    ],
  ),
  // Ha
  Lesson(
      letter: 'ه',
      audioAssetPath: 'assets/Ha.m4a',
      words: [
        Word(arabicText: 'هَ', startMilliSeconds: 800, endMilliSeconds: 2200),
        Word(arabicText: 'هِ', startMilliSeconds: 3000, endMilliSeconds: 4400),
        Word(arabicText: 'هُ', startMilliSeconds: 5300, endMilliSeconds: 6600),
        Word(arabicText: 'اَهْ', startMilliSeconds: 7300, endMilliSeconds: 8600),
        Word(arabicText: 'هَبْ', startMilliSeconds: 9800, endMilliSeconds: 10700),
        Word(arabicText: 'هَمْ', startMilliSeconds: 12300, endMilliSeconds: 13200),
        Word(arabicText: 'هَلْ', startMilliSeconds: 14600, endMilliSeconds: 15600),
        Word(arabicText: 'هُوَ', startMilliSeconds: 16900, endMilliSeconds: 17800),
        Word(arabicText: 'هِيَ', startMilliSeconds: 19250, endMilliSeconds: 20100),
        Word(arabicText: 'هُمْ', startMilliSeconds: 21700, endMilliSeconds: 22600),
        Word(arabicText: 'زُهْ', startMilliSeconds: 24150, endMilliSeconds: 25200),
        Word(arabicText: 'اَهَمْ', startMilliSeconds: 26700, endMilliSeconds: 27800),
        Word(arabicText: 'وَهَبْ', startMilliSeconds: 29550, endMilliSeconds: 30600),
        Word(arabicText: 'لَهَبْ', startMilliSeconds: 32400, endMilliSeconds: 33500),
        Word(arabicText: 'وَهَمْ', startMilliSeconds: 35400, endMilliSeconds: 36500),
        Word(arabicText: 'لَهُمْ', startMilliSeconds: 38200, endMilliSeconds: 39600),
        Word(arabicText: 'بِهِمْ', startMilliSeconds: 41150, endMilliSeconds: 42400),
        Word(arabicText: 'مِنْهُ', startMilliSeconds: 44250, endMilliSeconds: 45800),
        Word(arabicText: 'مِنْهُمْ', startMilliSeconds: 47700, endMilliSeconds: 49600),
        Word(arabicText: 'اِلَيْهِ', startMilliSeconds: 51650, endMilliSeconds: 53300),
        Word(arabicText: 'اِلَيْهِمْ', startMilliSeconds: 55400, endMilliSeconds: 57300),
        Word(arabicText: 'اَمْهِلْهُمْ', startMilliSeconds: 59500, endMilliSeconds: 62100),
      ]
  ),
  // Fa
  Lesson(
      letter: 'ف',
      audioAssetPath: 'assets/Fa.m4a',
      words: [
        Word(arabicText: 'فَ',     startMilliSeconds: 800,   endMilliSeconds: 1700),
        Word(arabicText: 'فِ',     startMilliSeconds: 2920,  endMilliSeconds: 4100),
        Word(arabicText: 'فُ',     startMilliSeconds: 4600,  endMilliSeconds: 5700),
        Word(arabicText: 'اَفْ',    startMilliSeconds: 7000,  endMilliSeconds: 8300),
        Word(arabicText: 'فَمْ',    startMilliSeconds: 9400,  endMilliSeconds: 10700),
        Word(arabicText: 'فَنْ',    startMilliSeconds: 12400, endMilliSeconds: 13740),
        Word(arabicText: 'كَفْ',    startMilliSeconds: 14800, endMilliSeconds: 16220),
        Word(arabicText: 'فَلَكْ',   startMilliSeconds: 17980, endMilliSeconds: 19120),
        Word(arabicText: 'كَفَنْ',   startMilliSeconds: 20720, endMilliSeconds: 22060),
        Word(arabicText: 'نَفَرْ',   startMilliSeconds: 23940, endMilliSeconds: 25020),
        Word(arabicText: 'فَوْرُ',   startMilliSeconds: 26960, endMilliSeconds: 28720),
        Word(arabicText: 'فَوْزُ',   startMilliSeconds: 29820, endMilliSeconds: 32040),
        Word(arabicText: 'فَهْمُ',   startMilliSeconds: 33840, endMilliSeconds: 35440),
        Word(arabicText: 'فِكْرُ',   startMilliSeconds: 37320, endMilliSeconds: 39020),
        Word(arabicText: 'زِفْرُ',   startMilliSeconds: 40640, endMilliSeconds: 43200),
        Word(arabicText: 'كِفْلُ',   startMilliSeconds: 43940, endMilliSeconds: 45600),
        Word(arabicText: 'فُلْفُلْ',  startMilliSeconds: 46860, endMilliSeconds: 49420),
        Word(arabicText: 'نَوْفَرْ',  startMilliSeconds: 51360, endMilliSeconds: 53160),
        Word(arabicText: 'نَوْفَلْ',  startMilliSeconds: 55020, endMilliSeconds: 56700),
        Word(arabicText: 'فَهِمَ',   startMilliSeconds: 58540, endMilliSeconds: 59740),
        Word(arabicText: 'يَفْهَمُ',  startMilliSeconds: 61900, endMilliSeconds: 63540),
        Word(arabicText: 'اِفْهَمْ',  startMilliSeconds: 65820, endMilliSeconds: 67320),
        Word(arabicText: 'اِفْتَتَنَ', startMilliSeconds: 68460, endMilliSeconds: 71220),
        Word(arabicText: 'يفْتَتِنُ', startMilliSeconds: 73480, endMilliSeconds: 75520),
        Word(arabicText: 'اِفْتَكَرَ', startMilliSeconds: 77560, endMilliSeconds: 79280),
        Word(arabicText: 'يَفْتَكِرُ', startMilliSeconds: 81380, endMilliSeconds: 83320),
      ]
  )
];