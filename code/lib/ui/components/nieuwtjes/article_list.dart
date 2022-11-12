import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/news_article.dart';
import 'package:waaiburg_app/data/repositories/news_repository.dart';
import 'package:waaiburg_app/main.dart';
import 'package:waaiburg_app/ui/components/nieuwtjes/article_card.dart';

const Max = 1000;
const PageSize = 30;

class ArticleList extends StatefulWidget {
  ArticleList({Key key}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final _controller = ScrollController();

  final _articleRepository = NewsRepository();

  List<NewsArticle> articles = [];

  int get articleCount => this.articles.length;
  int get limit => 999999;

  bool isConnectedToInternet = true;

  @override
  Future<void> initState() {
    super.initState();

    loadArticles();

    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        loadArticles();
      }
    });
  }

  loadArticles() async {
    print("Count: " + articleCount.toString());
    if (articleCount >= Max) return;

/*
    if (isConnectedToInternet == false) {
      var articles = await _articleRepository.getArticles(5, articleCount,
          fromCache: true);
      print("here");
      if (articles != null) {
        setState(
          () {
            print("Added ${articles.length} from cache.");
            this.articles.addAll(articles);
          },
        );
      }
    }
*/
    var articles =
        await _articleRepository.getArticles(5, articleCount, fromCache: false);
    if (articles != null) {
      setState(
        () {
          print("Added ${articles.length} from network.");

          this.articles.addAll(articles);
        },
      );
    } else if (this.articles.length == 0)
      setState(
        () {
          isConnectedToInternet = false;
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 0.13 * screenHeight),
      child: Stack(
        children: [
          if (isConnectedToInternet == false && articleCount == 0)
            Center(
              child: Text(WaaiburgApp.NoInternetMessage),
            )
          else if (articles == null || articles.length == 0)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            ListView(
              padding: EdgeInsets.only(top: 0),
              controller: _controller,
              children: articles
                  .map((a) => ArticleCard(
                        article: a,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
