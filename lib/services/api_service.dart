import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //api에서 data불러오는 과정

  static Future<List<WebtoonModel>> getTodayToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    //api에 http요청을 보내는 과정

    //http.get은 반환 타입이 Future라고 뜸 (미래에 받을 반환값의 타입을 알려줌 api를 이용하게 되면 느려질 수 있으므로 응답을 반환할 때까지 기다림)
    //즉 당장 응답을 받을 수 없는 경우이므로 future가 마무리되기를 기다렸다가 final respone = ~로 response값을 저장
    //이런걸 async(비동기) programming이라 부름
    //서버가 응답할 때까지 프로그램을 기다리게 하는 것.
    //기다리게 안하면 api에 요청만하고 getTodayToons 함수를 계속 실행시켜버리게 되니까
    //그래서 async와 await을 추가해줌
    if (response.statusCode == 200) {
      //statusCode가 200이면 요청에 성공했다는 뜻
      final List<dynamic> webtoons = jsonDecode(response.body);
      //reseonse의 body는 String이므로 json으로 변환하는 과정이 jsonDecode(원래 응답의 포맷은 json이므로)
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        //api에서 받은 json에서, fromJson이라는 named constructor을 사용해서
        //webtoonModel를 만들고 webtoonInstance이라는 리스트에 for문에 따라 하나씩 추가
        //fromJson을 쓰지 않고 할 수도 있음 WebtoonModel class에서 late를 지정해주면 됨
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
