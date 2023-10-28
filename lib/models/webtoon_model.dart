class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'], //title은 json의 title의 값으로 초기화,
        thumb = json['thumb'], //thumb은 json의 thumb의 값으로,
        id = json['id']; //id도 마찬가지
  //name constructor
}
