import 'package:dio/dio.dart';
import '../model/quran_model.dart';

class QuranService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.alquran.cloud/v1'));

  Future<List<Surah>> getSurahs() async {
    try {
      final response = await _dio.get('/surah');
      final List data = response.data['data'];
      return data.map((json) => Surah.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load surahs: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAyahs(int surahNumber) async {
    try {
      final response = await _dio.get('/surah/$surahNumber');
      final List ayahs = response.data['data']['ayahs'];
      return ayahs.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to load ayahs: $e');
    }
  }
}
