import 'package:dio/dio.dart';
import 'package:islam/features/hadith/data/model/hadith_model.dart';

class HadithService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://hadithapi.com/public/api/",
      responseType: ResponseType.json,
    ),
  );

  Future<HadithModel> getHadith() async {
    try {
      final response = await _dio.get(
        "hadiths",
        queryParameters: {
          "apiKey": r"$2y$10$46nX4FENFIix1TNPbkvTOQKtb1mo27rsMTMJBm2iJUCywzSDz486",
        },
      );

      return HadithModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load hadiths: $e');
    }
  }
}
