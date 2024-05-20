import 'package:flutter/widgets.dart';

class ProfileImageCircleWidget extends StatelessWidget {
  const ProfileImageCircleWidget({
    required this.size,
    required this.url,
    super.key,
  });

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        url ?? '',
        fit: BoxFit.cover,
      ),
    );
  }
}
