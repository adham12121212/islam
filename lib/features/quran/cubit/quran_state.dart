

import '../data/model/quran_model.dart';

abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Surah> surahs;
  QuranLoaded(this.surahs);
}

class QuranError extends QuranState {
  final String message;
  QuranError(this.message);
}

class AyahsLoading extends QuranState {}

class AyahsLoaded extends QuranState {
  final List<Map<String, dynamic>> ayahs;
  AyahsLoaded(this.ayahs);
}

class AyahsError extends QuranState {
  final String message;
  AyahsError(this.message);
}
