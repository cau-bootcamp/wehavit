import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:wehavit/common/constants/app_colors.dart';

class CircleProfileImage extends StatelessWidget {
  const CircleProfileImage({
    required this.size,
    required this.url,
    super.key,
  });

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.whGrey600,
      ),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, _) => Container(color: CustomColors.whGrey600),
        errorWidget: (context, _, __) => Container(color: CustomColors.whGrey600),
      ),
    );
  }
}
