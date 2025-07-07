import 'package:wallpaper_app/features/home/domain/entities/wallpaper_entity.dart';

class WallpaperModel extends WallpaperEntity {
  WallpaperModel({
    required super.alt,
    required super.imgUrl,
    required super.url,
    required super.photographer,
  });
  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
      alt: json['alt'] ?? '',
     imgUrl: json['src']!['portrait'] ?? '',
      url: json['url'] ?? '', 
      photographer: json['photographer'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'alt': alt,
      'imgUrl': imgUrl,
      'url': url,
      'photographer': photographer,
    };
  }
}
