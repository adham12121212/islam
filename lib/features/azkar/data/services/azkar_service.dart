import 'package:dio/dio.dart';
import '../model/azkar_model.dart';

class AzkarService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://ahegazy.github.io/muslimKit/json",
      responseType: ResponseType.json,
    ),
  );

  Future<List<AzkarModel>> getAzkar() async {
    try {
      final response = await _dio.get('/azkar_sabah.json');

      // The JSON is a single object, so parse directly
      final AzkarModel azkar = AzkarModel.fromJson(response.data);

      // Wrap it in a list to match your Cubit
      return [azkar];
    } catch (e) {
      throw Exception('Failed to load azkar: $e');
    }
  }
}
