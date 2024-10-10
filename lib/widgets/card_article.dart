import 'package:dicoding_news_app/cummon/navigation.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_news_app/cummon/styles.dart';

// CardArticle dengan meng-extends  kelas StatelessWidget.
// widget yang berfungsi untuk menampilkan item data yang bersumber dari list berita.
// Kemudian widget ini juga merupakan turunan dari kelas StatelessWidget yang berarti widget
// ini tidak akan melakukan perubahan state apapun melainkan hanya menerima dan menampilkan data saja.
class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({required this.article});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: article.urlToImage!,
          // gunakan SizedBox agar terhindar error Leading widget consumes entire tile width di ListTile
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              article.urlToImage!,
              fit: BoxFit.cover,
              // width: 100,
            ),
          ),
        ),
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author ?? ""),
        onTap: () =>
            Navigation.intentWithData(ArticleDetailPage.routeName, article),
        //  di matikan karna menggunakan class navigation
        // onTap: () => Navigator.pushNamed(
        //   context,
        //   ArticleDetailPage.routeName,
        //   arguments: article,
        // ),
      ),
    );
  }
}
