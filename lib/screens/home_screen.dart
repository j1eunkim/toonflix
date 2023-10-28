import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodayToons();

  //state는 UI와 변할 수 있는 데이터를 가지고 있음
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // scaffold는 screen을 위한 기본적인 레이아웃과 설정을 제공
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 61, 165, 64),
        title: const Text(
          "Today's webtoon",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: ((context, snapshot) {
          //snapshot이름은 바꿔도 되는 값임)
          //snapshot을 이용하면 future의 상태를 알 수 있음(데이터를 받았는지 오류가 났는지)
          //statelesswidget에서도 widget들을 적절히 활용하면 이렇게 future을 await을 쓰거나 isLoading 쓸 필요없이 state를 확인할 수 있음
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ) //separatorbuilder는 추가로 구분자를 넣어주는 최적화된 버전
                //listview는 hasdata가 data를 가지고 있을 때만 o
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
            //loading 모양이 자체로 돌아감
          );
        }),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            thumb: webtoon.thumb, title: webtoon.title, id: webtoon.id);
      }, //itembuilder는 item을 한번에 다 load하는게 아니라 필요하면 load함(스크롤을 넘긴다든지)
      separatorBuilder: (context, index) => const SizedBox(
        width: 25,
      ),
    );
  }
}
