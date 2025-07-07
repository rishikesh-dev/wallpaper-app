import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/search/domain/entities/search_entity.dart';
import 'package:wallpaper_app/features/search/domain/repositories/search_repository.dart';

class SearchWallpaperUseCase {
  final SearchRepository repository;

  SearchWallpaperUseCase({required this.repository});
  Future<Either<Failure, List<SearchEntity>>> call(String query) async {
    return repository.searchWallpapers(query);
  }
}
