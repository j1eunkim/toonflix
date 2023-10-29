import 'package:toonflix/widgets/webtoon_widget.dart';

class WebtoonEpisodeModel {
  final String id, title, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        id = json['id'],
        rating = json['rating'],
        title = json['title'];
}
