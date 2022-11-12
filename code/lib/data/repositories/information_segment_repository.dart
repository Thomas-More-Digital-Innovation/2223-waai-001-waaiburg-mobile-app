import 'package:waaiburg_app/data/custom_cache_manager.dart';
import 'package:waaiburg_app/data/models/information_segment.dart';
import 'package:waaiburg_app/environment/environment.dart';
import 'dart:convert' as convert;

enum JongerenOfVolwassenen { Jongeren, Volwassenen }

class InformationSegmentRepository {
  Future<List<InformationSegment>> getSegments(
      JongerenOfVolwassenen jongerenOfVolwassenen,
      {bool fromCache}) async {
    /*https://waaiburgwebapp.sinners.be/api/infoSegment/read.php?read=jongeren  */
    String jongOfVolw = jongerenOfVolwassenen == JongerenOfVolwassenen.Jongeren
        ? "jongeren"
        : "volwassenen";
    final uri = Uri.https(Environment().config.apiHost,
        "/api/infoSegment/read_full.php", {"read": jongOfVolw});

    try {
      var file = fromCache
          ? await CustomCacheManager.instance.getFileFromCache(uri.toString())
          : await CustomCacheManager.instance
              .downloadFile(uri.toString(), force: true);

      if (file == null) return null;

      var jsonData = convert.jsonDecode(await file.file.readAsString());

      var segments = jsonData
          .map((result) => InformationSegment.fromJson(result))
          .toList()
          .cast<InformationSegment>();

      return segments;
    } catch (e) {
      return null;
    }
  }

   Future<int> getBlockListLength(InformationSegment segment,
      {bool fromCache}) async {
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

}