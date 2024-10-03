import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/widgets/card_article.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    // fungsi Widget PlatformWidget sudah dipindahkan ke artcle_list_page
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
    // karna sudah di bungkus menjadi PlatformWidget yg nanti akan berubah sesuai ios/andro
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       'News App',
    //     ),
    //   ),
    //   body: _buildList(context),
    // );
  }

  // Untuk fatching JSON dari assets/articles.json model article.dart
  // FutureBuilder<String> _buildList(BuildContext context) {
  //   return FutureBuilder<String>(
  //     future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
  //     builder: (context, snapshot) {
  //       final List<Article> articles = parseArticles(snapshot.data);
  //       return ListView.builder(
  //         itemCount: articles.length,
  //         itemBuilder: (context, index) {
  //           return _buildArticleItem(context, articles[index]);
  //         },
  //       );
  //     },
  //   );
  // }

  // untuk fatching API dari http
  Widget _buildList(BuildContext context) {
    return FutureBuilder<ArticlesResult>(
      future: _article,
      builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.articles.length,
              itemBuilder: (context, index) {
                var article = snapshot.data?.articles[index];
                return CardArticle(article: article!);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Material(child: Text(''));
          }
        }
      },
    );
  }

  // Widget _buildArticleItem(BuildContext context, Article article) {
  //   // bungkus menggunakan material karna di ios ga bisa langsung ListTile
  //   return Material(
  //     child: ListTile(
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //       // Hero animation
  //       leading: Hero(
  //         tag: article.urlToImage!,
  //         child: Image.network(
  //           article.urlToImage!,
  //           width: 100,
  //         ),
  //       ),
  //       title: Text(
  //         article.title,
  //         style: Theme.of(context).textTheme.titleMedium,
  //       ),
  //       subtitle: Text(article.author!),
  //       onTap: () {
  //         Navigator.pushNamed(context, ArticleDetailPage.routeName,
  //             arguments: article);
  //       },
  //     ),
  //   );
  // }

  // Widget ini untuk tampilan Android
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  // Widget ini untuk tampilan IOS
  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('News App'),
        // tambahkan transition sebelum route
        // Tujuannya adalah agar tidak ada tag hero yang duplikat karena ada halaman baru.
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }
}
