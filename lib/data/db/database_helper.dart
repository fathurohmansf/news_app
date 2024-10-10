// import 'package:dicoding_news_app/data/model/article.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// class DatabaseHelper {
//   static DatabaseHelper? _instance;
//   static Database? _database;

//   DatabaseHelper._internal() {
//     _instance = this;
//   }

//   factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

//   static const String _tblBookmark = 'bookmarks';

//   Future<Database> _initializeDb() async {
//     var path = await getDatabasesPath();
//     var db = openDatabase(
//       '$path/newsapp.db',
//       onCreate: (db, version) async {
//         await db.execute('''CREATE TABLE $_tblBookmark (
//             sourceName TEXT PRIMARY KEY,
//             url TEXT,
//             author TEXT,
//             title TEXT,
//             description TEXT,
//             urlToImage TEXT,
//             publishedAt TEXT,
//             content TEXT
//           )
//         ''');
//       },
//       version: 1,
//     );

//     return db;
//   }

//   Future<Database?> get database async {
//     if (_database == null) {
//       _database = await _initializeDb();
//     }

//     return _database;
//   }

//   // query untuk menyimpan data
//   Future<void> insertBookmark(Article article) async {
//     final db = await database;
//     await db!.insert(_tblBookmark, article.toJson());
//     // final db = await database;
//     // await db!.insert(_tblBookmark, {
//     //   'sourceId': article.source.id,
//     //   // 'sourceName': article.source.name,
//     //   'url': article.url,
//     //   'author': article.author,
//     //   'title': article.title,
//     //   'description': article.description,
//     //   'urlToImage': article.urlToImage,
//     //   'publishedAt': article.publishedAt.toIso8601String(),
//     //   'content': article.content,
//     // });
//   }
//   // Future<void> insertBookmark(Article article) async {
//   //   final db = await database;
//   //   await db!.insert(_tblBookmark, article.toJson());
//   // }

//   // query untuk Mendapatkan ALL Data
//   // Future<List<Article>> getBookmarks() async {
//   //   final db = await database;
//   //   List<Map<String, dynamic>> results = await db!.query(_tblBookmark);

//   //   return results
//   //       .map((res) => Article(
//   //             source: Source(id: res['sourceId'], name: res['sourceName']),
//   //             author: res['author'],
//   //             title: res['title'],
//   //             description: res['description'],
//   //             url: res['url'],
//   //             urlToImage: res['urlToImage'],
//   //             publishedAt: DateTime.parse(res['publishedAt']),
//   //             content: res['content'],
//   //           ))
//   //       .toList();
//   // }
//   Future<List<Article>> getBookmarks() async {
//     final db = await database;
//     List<Map<String, dynamic>> results = await db!.query(_tblBookmark);

//     return results.map((res) => Article.fromJson(res)).toList();
//   }

//   // query untuk mencari bookmark yang disimpan berdasarkan url
//   // dan cek status bookmark atay tidak
//   Future<Map> getBookmarkByUrl(String url) async {
//     final db = await database;

//     List<Map<String, dynamic>> results = await db!.query(
//       _tblBookmark,
//       where: 'url = ?',
//       whereArgs: [url],
//     );

//     if (results.isNotEmpty) {
//       return results.first;
//     } else {
//       return {};
//     }
//   }

//   // query untuk menghapuis data bookmark berdasarkan url
//   Future<void> removeBookmark(String url) async {
//     final db = await database;

//     await db!.delete(
//       _tblBookmark,
//       where: 'url = ?',
//       whereArgs: [url],
//     );
//   }
// }
