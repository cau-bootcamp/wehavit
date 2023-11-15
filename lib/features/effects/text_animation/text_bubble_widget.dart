import 'package:flutter/material.dart';

class TextBubbleFrameWidget extends StatelessWidget {
  const TextBubbleFrameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextBubbleWidget(
              message: '오늘도 화이팅 화이팅!!',
              userImageUrl:
                  'https://i.namu.wiki/i/TrdI_AZmxU2LZKqbM03iBQ42-hh9iSA3Hre27jXgLXwbQxKFV6OJ0hB2qksroJwTUvBU6yogPa3QbfCRKtWHqA.webp',
            ),
          ],
        ),
      ),
    );
  }
}

class TextBubbleWidget extends StatelessWidget {
  const TextBubbleWidget({
    super.key,
    required this.message,
    required this.userImageUrl,
  });

  final String message;
  final String userImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                foregroundImage: NetworkImage(userImageUrl),
              ),
            ),
          ],
        )
      ],
    );
  }
}
