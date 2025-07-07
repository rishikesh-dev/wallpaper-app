import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:wallpaper_app/core/errors/failure.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/features/search/data/models/search_model.dart';
import 'package:wallpaper_app/features/search/domain/entities/search_entity.dart';

abstract class PexelRemoteDataSource {
  Future<Either<Failure, List<SearchEntity>>> searchWallpaper(String query);
}

class PexelRemoteDataSourceImpl extends PexelRemoteDataSource {
  final String apiKey;

  PexelRemoteDataSourceImpl({required this.apiKey});

  @override
  Future<Either<Failure, List<SearchEntity>>> searchWallpaper(
    String query,
  ) async {
    try {
      final uri = Uri.https('api.pexels.com', '/v1/search', {
        'query': query.trim(),
        'per_page': '80',
      });

      final response = await http.get(uri, headers: {'Authorization': apiKey});

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> photoList = json['photos'];

        final photos = photoList
            .map((photoJson) => SearchModel.fromJson(photoJson))
            .toList();

        return Right(photos);
      } else {
        return Left(Failure('Failed to fetch wallpapers'));
      }
    } catch (e) {
      return Left(Failure('Exception: ${e.toString()}'));
    }
  }
}
