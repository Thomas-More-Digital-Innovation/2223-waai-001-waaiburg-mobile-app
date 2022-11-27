import 'package:waaiburg_app/data/models/news_article.dart';
import 'package:waaiburg_app/environment/environment.dart';
import 'dart:convert' as convert;

import '../custom_cache_manager.dart';

class NewsRepository {
  Future<List<NewsArticle>> getArticles(int aantal, int offset, {bool fromCache}) async {
    final uri = Uri.https(Environment().config.apiHost, "/api/nieuwtjes/read_some.php",
        {"aantal": aantal.toString(), "offset": offset.toString()});

    print(aantal);

    try {
      var file = fromCache
          ? await CustomCacheManager.instance.getFileFromCache(uri.toString())
          : await CustomCacheManager.instance.downloadFile(uri.toString(), force: true);

      if (file == null) return null;

      var jsonData = convert.jsonDecode(await file.file.readAsString());

      var segments = jsonData.map((result) => NewsArticle.fromJson(result)).toList().cast<NewsArticle>();

      return segments;
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<NewsArticle> getDetails(NewsArticle article, {bool fromCache}) async {
    final uri = Uri.https(Environment().config.apiHost, "/api/nieuwtjes/read_single.php", {"id": article.id.toString()});

    try {
      var file = fromCache
          ? await CustomCacheManager.instance.getFileFromCache(uri.toString())
          : await CustomCacheManager.instance.downloadFile(uri.toString(), force: true);

      if (file == null) return article;

      var jsonData = convert.jsonDecode(await file.file.readAsString());

      article.content = jsonData["inhoud"];
      return article;
    } catch (e) {
      return article;
    }
  }
}
