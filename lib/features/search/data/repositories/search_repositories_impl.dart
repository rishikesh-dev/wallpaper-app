import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:wallpaper_app/features/search/data/remote_data_sources/pexel_remote_data_source.dart';
import 'package:wallpaper_app/features/search/domain/entities/search_entity.dart';
import 'package:wallpaper_app/features/search/domain/repositories/search_repository.dart';

class SearchRepositoriesImpl extends SearchRepository {
  final PexelRemoteDataSource remoteDataSource;

  SearchRepositoriesImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure,List<SearchEntity>>> searchWallpapers(String query) async {
    try {
      return await remoteDataSource.searchWallpaper(query);
    } catch (e) {
      throw Exception(e);
    }
  }
}
