import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;

  final _blackColor = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isInverted ? Colors.white : _blackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: isInverted ? _blackColor : Colors.white,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      code,
                      style: TextStyle(
                        color: isInverted
                            ? _blackColor
                            : Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Transform.scale(
              //부모 속성에 영향을 주지 않고 크기변경가능(card전체 크기는 그대로)
              scale: 3,
              //3배 키워줌
              child: Transform.translate(
                offset: const Offset(-3, 7),
                child: Icon(
                  icon,
                  color: isInverted ? _blackColor : Colors.white,
                  size: 50,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
