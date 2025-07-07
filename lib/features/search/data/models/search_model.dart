import 'package:wallpaper_app/features/search/domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.imgUrl,
    required super.title,
    required super.photographer,
  });
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      imgUrl: json['src']!['portrait'] ?? '',
      title: json['alt'],
      photographer: json['photographer'],
    );
  }
  Map<String, dynamic> toJson() {
    return {imgUrl: 'imgUrl', title: 'title', photographer: 'photographer'};
  }
}
