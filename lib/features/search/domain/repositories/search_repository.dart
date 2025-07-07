import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/search/domain/entities/search_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchEntity>>> searchWallpapers(String query);
}
