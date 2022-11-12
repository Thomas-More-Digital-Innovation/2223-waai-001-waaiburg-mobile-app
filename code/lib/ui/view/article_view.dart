import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/news_article.dart';
import 'package:waaiburg_app/ui/components/nieuwtjes/article_details.dart';

class ArticleView extends StatelessWidget {
  final NewsArticle article;

  const ArticleView({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArticleDetail(article: article);
  }
}
