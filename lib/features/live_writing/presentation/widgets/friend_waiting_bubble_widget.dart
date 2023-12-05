import 'package:flutter/material.dart';

class WaitingStateUserBubble extends StatelessWidget {
  const WaitingStateUserBubble({
    super.key,
    required this.userImage,
  });

  final ImageProvider<Object> userImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 35,
              foregroundImage: userImage,
            ),
          ),
          Positioned(
            left: 46,
            bottom: 50,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xaa8C8C8C),
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 77,
              height: 35,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (_) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        width: 8,
                        height: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
