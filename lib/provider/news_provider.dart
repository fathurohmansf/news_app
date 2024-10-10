import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    // ketika kelas NewsProvider dipanggil oleh kelas lain, maka secara otomatis fungsi _fetchAllArticle() akan langsung dieksekusi atau dijalankan.
    _fetchAllArticle();
  }

  late ArticlesResult _articlesResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ArticlesResult get result => _articlesResult;

  ResultState get state => _state;

  // fungsi _fetchAllArticle() ini bertugas melakukan proses pengambilan data dari internet.
  // fungsi _fetchAllArticle() juga terdapat kondisi try catch dan ada beberapa kondisi state untuk menangani proses loading, sukses, tidak ada data, dan eror oleh kelas enum bernama ResultState.
  // bersifat dymanic juga bisa objek,tipedata, dll.
  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      // fungsi notifyListeners()  bertugas layaknya seperti setState() pada kelas yang turunan dari kelas StatefulWidget
      // dapat bertugas seperti setState() juga
      notifyListeners();
      // proses nya di handle oleh apiService
      final article = await apiService.topHeadlines();
      if (article.articles.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
