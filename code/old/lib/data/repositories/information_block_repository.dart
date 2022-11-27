import 'package:waaiburg_app/data/custom_cache_manager.dart';
import 'package:waaiburg_app/data/models/information_block.dart';
import 'package:waaiburg_app/data/models/information_segment.dart';
import 'package:waaiburg_app/environment/environment.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class InformationBlockRepository {
  Future<List<InformationBlock>> getInfoBlocks(InformationSegment segment,
      {bool fromCache}) async {
    /*https://waaiburgwebapp.sinners.be/api/infoBlok/readForSegment.php?id=0   */
    final uri = Uri.https(
        Environment().config.apiHost,
        "/api/infoBlok/readForSegment.php",
        {"id": segment.infoSegmentId.toString()});

    try {
      var file = fromCache
          ? await CustomCacheManager.instance.getFileFromCache(uri.toString())
          : await CustomCacheManager.instance
              .downloadFile(uri.toString(), force: true);

      if (file == null) return null;

      var jsonData = convert.jsonDecode(await file.file.readAsString());
      var blocks = jsonData
          .map((result) => InformationBlock.fromJson(result))
          .toList()
          .cast<InformationBlock>();
      return blocks;
    } catch (e) {
      return null;
    }
  }

  Future<int> getBlockListLength(InformationSegment segment) async {
    /*https://waaiburgwebapp.sinners.be/api/infoBlok/readForSegment.php?id=0   */
    final uri = Uri.https(
        Environment().config.apiHost,
        "/api/infoBlok/readForSegment.php",
        {"id": segment.infoSegmentId.toString()});

    try {
      var file = await CustomCacheManager.instance
          .downloadFile(uri.toString(), force: true);

      if (file == null) return 0;

      var length = convert.jsonDecode(await file.file.readAsString()).length;

      return length;
    } catch (e) {
      return e;
    }
  }

  Future<InformationBlock> getInfoBlockDetails(InformationBlock block,
      {bool fromCache}) async {
    /*https://waaiburgwebapp.sinners.be/api/infoBlok/read_single.php?id=0   */
    final uri = Uri.https(Environment().config.apiHost,
        "/api/infoBlok/read_single.php", {"id": block.infoBlokId.toString()});

    try {
      var file = fromCache
          ? await CustomCacheManager.instance.getFileFromCache(uri.toString())
          : await CustomCacheManager.instance
              .downloadFile(uri.toString(), force: true);

      if (file == null) return block;

      var jsonData = convert.jsonDecode(await file.file.readAsString());

      block.inhoud = jsonData["inhoud"];
      block.meerInfoLink = jsonData["meerInfoLink"];
      return block;
    } catch (e) {
      return block;
    }
  }
}
