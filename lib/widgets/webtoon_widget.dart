import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
  const Webtoon({
    super.key,
    required this.thumb,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //gesturedector은 동작을 감지해줌 onTop, onLongPress 등...
      onTap: () {
        //homescreen을 누르게 되면 이제 homescreen을 떠나기 때문에 scffold를 detailscreen에 먼저 렌더해줄 것
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: true,
          ),
        );
        //route란 detailscreen같은 statelesswidget을
        //애니메이션 효과로 감싸서 스크린'처럼' 보이게 한다는 것
        //navigator가 statelesswidget을 원하지 않기 때문에 바로 detailscreen을 route에 적을 수는 없음음
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(8, 8),
                      color: Colors.black.withOpacity(0.5),
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
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
