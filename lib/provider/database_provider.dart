// import 'package:dicoding_news_app/data/db/database_helper.dart';
// import 'package:dicoding_news_app/data/model/article.dart';
// import 'package:dicoding_news_app/provider/news_provider.dart';
// import 'package:flutter/material.dart';

// class DatabaseProvider extends ChangeNotifier {
//   final DatabaseHelper databaseHelper;

//   DatabaseProvider({required this.databaseHelper}) {
//     _getBookmarks();
//   }

//   late ResultState _state;
//   ResultState get state => _state;

//   String _message = '';
//   String get message => _message;

//   List<Article> _bookmarks = [];
//   List<Article> get bookmarks => _bookmarks;

//   //
//   void _getBookmarks() async {
//     _bookmarks = await databaseHelper.getBookmarks();
//     if (_bookmarks.length > 0) {
//       _state = ResultState.hasData;
//     } else {
//       _state = ResultState.noData;
//       _message = 'Empty Data';
//     }
//     notifyListeners();
//   }

//   // add
//   void addBookmark(Article article) async {
//     try {
//       await databaseHelper.insertBookmark(article);
//       _getBookmarks();
//     } catch (e) {
//       _state = ResultState.error;
//       _message = 'Error: $e';
//       notifyListeners();
//     }
//   }

//   //
//   Future<bool> isBookmarked(String url) async {
//     final bookmarkedArticle = await databaseHelper.getBookmarkByUrl(url);
//     return bookmarkedArticle.isNotEmpty;
//   }

//   // metode menghapus bookmark
//   void removeBookmark(String url) async {
//     try {
//       await databaseHelper.removeBookmark(url);
//       _getBookmarks();
//     } catch (e) {
//       _state = ResultState.error;
//       _message = 'Error: $e';
//       notifyListeners();
//     }
//   }
// }
