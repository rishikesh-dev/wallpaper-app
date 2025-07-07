import 'package:http/http.dart' as http;
import 'package:wallpaper_app/core/errors/failure.dart';
import 'dart:convert';

import 'package:wallpaper_app/features/home/data/models/wallpaper_model.dart';
import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';

abstract class PexelsApiRemoteDataSource {
  Future<List<WallpaperEntity>> getWallpapers(int page);
}

class PexelsApiRemoteDataSourceImpl extends PexelsApiRemoteDataSource {
  final String apiKey;

  PexelsApiRemoteDataSourceImpl({required this.apiKey});
  @override
  Future<List<WallpaperEntity>> getWallpapers(int page) async {
    final url = 'https://api.pexels.com/v1/curated?page=$page&per_page=80';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': apiKey},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List photos = data['photos'];
      return photos.map((photo) => WallpaperModel.fromJson(photo)).toList();
    } else {
      throw Exception(Failure('Failed to load wallpapers from Pexels API'));
    }
  }

}
