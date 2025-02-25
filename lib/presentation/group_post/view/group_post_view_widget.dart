import 'package:flutter/widgets.dart';
import 'package:wehavit/common/constants/app_colors.dart';

class NoPostPlaceholder extends StatelessWidget {
  const NoPostPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '아무도 인증글을 남기지 않은\n조용한 날이네요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          Text(
            '🤫',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: CustomColors.whWhite,
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
