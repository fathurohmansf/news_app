import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/ui/article_web_view.dart';
import 'package:dicoding_news_app/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: article.urlToImage!,
                // child: Image.network(article.urlToImage)),
                // pakai ! untuk abstrak
                child: Image.network(article.urlToImage!)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(article.description),
                  // gunakan ?? untuk abstrak tipe data
                  Text(
                    article.description ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    // style: const TextStyle(
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 24,
                    // ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('Date: ${article.publishedAt}'),
                  const SizedBox(height: 10),
                  Text('Author: ${article.author}'),
                  const Divider(color: Colors.grey),
                  Text(
                    article.content!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Read more'),
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebView.routeName,
                          arguments: article.url);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
