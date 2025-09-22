import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/service/quran_service.dart';
import 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final QuranService _service = QuranService();

  QuranCubit() : super(QuranInitial());

  Future<void> fetchSurahs() async {
    emit(QuranLoading());
    try {
      final surahs = await _service.getSurahs();
      emit(QuranLoaded(surahs));
    } catch (e) {
      emit(QuranError('Failed to load surahs: $e'));
    }
  }

  Future<void> fetchAyahs(int surahNumber) async {
    emit(AyahsLoading());
    try {
      final ayahs = await _service.getAyahs(surahNumber);
      emit(AyahsLoaded(ayahs));
    } catch (e) {
      emit(AyahsError('Failed to load ayahs: $e'));
    }
  }
}
