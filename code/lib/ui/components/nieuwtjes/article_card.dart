import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaiburg_app/data/models/news_article.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/ui/view/article_view.dart';

class ArticleCard extends StatelessWidget {
  final NewsArticle article;

  const ArticleCard({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => {
        appState.currentAction = PageAction(
            state: PageState.addWidget,
            widget: ArticleView(article: article),
            page: InformationBlockListPageConfig)
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5)
            ]),
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHeight * 0.01),
        child: Column(
          children: [
            Text(
              article.title.toUpperCase(),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.bold),
            ),
            /*Text(article.shortDescription),*/
            Html(
              data: article.shortDescription,
              style: {
                'p': Style(
                    color: Colors.black,
                    textAlign: TextAlign.start,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: FontSize.em(1.2)),
              },
              onImageTap: (src, _, __, ___) {
                print("Source:" + src);
              },
              onImageError: (exception, stackTrace) {
                print("Exception: " + exception);
              },
            ),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  /*
                  article.publishTime.day.toString().padLeft(2, "0") +
                      "/" +
                      article.publishTime.month.toString().padLeft(2, "0") +
                      "/" +
                      article.publishTime.year.toString().substring(2),
          */
                  "${article.publishTime.day} ${maandenStrings[article.publishTime.month].toLowerCase()} '${article.publishTime.year.toString().substring(2)}",
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const Map<int, String> maandenStrings = {
    1: "Januari",
    2: "Februari",
    3: "Maart",
    4: "April",
    5: "Mei",
    6: "Juni",
    7: "Juli",
    8: "Augustus",
    9: "September",
    10: "Oktober",
    11: "November",
    12: "December",
  };
}
