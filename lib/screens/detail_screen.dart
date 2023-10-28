import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});
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
            title,
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
                Container(
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
                    thumb,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
