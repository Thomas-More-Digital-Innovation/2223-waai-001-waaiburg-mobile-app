import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waaiburg_app/data/models/news_article.dart';
import 'package:waaiburg_app/data/repositories/news_repository.dart';
import 'package:waaiburg_app/main.dart';
import 'package:waaiburg_app/ui/components/rounded_headerbar.dart';

class ArticleDetail extends StatefulWidget {
  ArticleDetail({Key key, this.article}) : super(key: key);

  final NewsArticle article;

  @override
  _ArticleDetailState createState() => _ArticleDetailState(article);
}

class _ArticleDetailState extends State<ArticleDetail> {
  final _newsRepository = NewsRepository();

  NewsArticle article;

  bool isConnectedToInternet = true;

  _ArticleDetailState(this.article);

  @override
  void initState() {
    super.initState();

    loadBlockDetails();
  }

  loadBlockDetails() async {
    var article =
        await _newsRepository.getDetails(this.article, fromCache: true);

    if (article != null)
      setState(
        () {
          this.article = article;
        },
      );

    article = await _newsRepository.getDetails(this.article, fromCache: false);

    if (article == null || article.content == null || article.content.isEmpty) {
      setState(
        () {
          isConnectedToInternet = false;
        },
      );
    }
    if (article != null)
      setState(
        () {
          this.article = article;
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RoundedHeaderBar(
      headerName: article.title.stringFix,
      menuColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: size.height * 1,
            child: Stack(
              children: [
                if (isConnectedToInternet == false)
                  Center(
                    child: Text(WaaiburgApp.NoInternetMessage),
                  )
                else if (article == null ||
                    article.content == null ||
                    article.content.length == 0)
                  Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  )
                else
                  ListView(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    children: [
                      Container(
                        child: Html(
                          data: article.content,
                          style: {
                            'h1': Style(
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.secondary,
                              margin: EdgeInsets.all(0),
                            ),
                            'p': Style(
                              color: Colors.black,
                              // textAlign: TextAlign.start,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                              margin: EdgeInsets.all(0),
                            ),
                          },
                          onLinkTap: (url, _, __, ___) {
                            launch(url,
                                forceWebView: false,
                                enableJavaScript: true,
                                webOnlyWindowName: url);
                          },
                          onImageTap: (src, _, __, ___) {
                            print(src);
                          },
                          onImageError: (exception, stackTrace) {
                            print(exception);
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /*@override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: kToolbarHeight * 1.5,
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            //Header bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColorLight,
                ], begin: Alignment.topLeft),
              ),
            ),
            // Title
            Container(
              child: Center(
                child: Container(
                  width: screenWidth * 0.7,
                  height: kToolbarHeight * 1.0,
                  margin: EdgeInsets.only(top: 25),
                  child: Center(
                    child: AutoSizeText(
                      article.title.stringFix,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).primaryColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Back icon button
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 25),
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Theme.of(context).primaryColor,
                ),
                iconSize: 48,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight * 1,
            child: Stack(
              children: [
                if (isConnectedToInternet == false)
                  Center(
                    child: Text(WaaiburgApp.NoInternetMessage),
                  )
                else if (article == null ||
                    article.content == null ||
                    article.content.length == 0)
                  Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  )
                else
                  ListView(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.14),
                        child: Html(
                          data: article.content,
                          style: {
                            'h1': Style(
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.secondary,
                              margin: EdgeInsets.all(0),
                            ),
                            'p': Style(
                              color: Theme.of(context).shadowColor,
                              // textAlign: TextAlign.start,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                              margin: EdgeInsets.all(0),
                            ),
                          },
                          onLinkTap: (url, _, __, ___) {
                            launch(url,
                                forceWebView: false,
                                enableJavaScript: true,
                                webOnlyWindowName: url);
                          },
                          onImageTap: (src, _, __, ___) {
                            print(src);
                          },
                          onImageError: (exception, stackTrace) {
                            print(exception);
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  */
}
