import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dicoding_news_app/data/model/article.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '8eba1471a2774b46a3d70af2873fde2d';
  static const String _category = 'business';
  static const String _country = 'us';

  // topHeadlines() yang bertugas untuk melakukan request GET ke endpoint _baseURL
  // beserta dengan inputan data lainnya seperti _country, _category dan juga _apiKey.
  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      // ubah JSON tersebut menjadi model ArticlesResult
      // menggunakan metode .fromJson() yang sudah dibuat di kelas ArticlesResult.
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
