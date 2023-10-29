import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    //getToonById(id)가 아니라 widget.id로 적어야 하는 이유는 statelesswidget에서
    //statefullwidget으로 바뀌면서 title, thumb, id를 정의한 DetailScreen과는 별개의 class가 되었고
    //그래서 이 data를 받기 위해서는 부모 class로 가라는? 의미의 widget. 이 붙어야 하는 것임
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }
//homescreen에서는 id같은 argument가 필요하지 않아서? 이 과정이 필요없던 거임

  //어떤 웹툰을 클릭했는지 알 수 있어야 함(상세페이지 이므로)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // scaffold는 screen을 위한 기본적인 레이아웃과 설정을 제공
        // 뒤로가기 이런것도 제공해줌
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: const Color.fromARGB(255, 61, 165, 64),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(8, 8),
                            color: Colors.red.withOpacity(0.5),
                          )
                        ]),
                    child: Image.network(
                      widget.thumb,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
