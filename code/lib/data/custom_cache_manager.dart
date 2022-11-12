import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// ignore: implementation_imports
import 'package:flutter_cache_manager/src/storage/file_system/file_system_io.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 99999999),
      maxNrOfCacheObjects: 200,
      repo: CacheObjectProvider(databaseName: "waaiburg_database"),
      fileService: HttpFileService(),
	  fileSystem: IOFileSystem(key),
    ),
  );
}