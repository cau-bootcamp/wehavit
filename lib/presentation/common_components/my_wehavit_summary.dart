import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/presentation.dart';
import 'package:wehavit/presentation/state/user_data/my_user_data_provider.dart';

class MyWehavitSummary extends StatelessWidget {
  const MyWehavitSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 150),
      decoration: const BoxDecoration(
        color: CustomColors.whSemiBlack,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final asyncMyUserData = ref.read(getMyUserDataProvider);

                return asyncMyUserData.when(
                  data: (userEntity) {
                    return Column(
                      children: [
                        UserProfileCell(
                          userEntity.userId,
                          type: UserProfileCellType.profile,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        VerticalLineWrapper(
                          contents: [
                            _MyWehavitSummaryBullet(
                              iconString: WHIcons.emojiCalendar,
                              preText: '위해빗과 함께한 지 ',
                              highlightedText: '${DateTime.now().difference(userEntity.createdAt).inDays + 1}일째',
                              postText: '가 되었어요.',
                            ),
                            const SizedBox(height: 12),
                            _MyWehavitSummaryBullet(
                              iconString: WHIcons.emojiPigeon,
                              preText: '지금까지 ',
                              highlightedText: '${userEntity.cumulativeGoals}개',
                              postText: '의 목표에 도전했어요',
                            ),
                            const SizedBox(height: 12),
                            _MyWehavitSummaryBullet(
                              iconString: WHIcons.emojiEyes,
                              preText: '벌써 ',
                              highlightedText: '${userEntity.cumulativePosts}개',
                              postText: '의 실천을 인증했어요!',
                            ),
                            const SizedBox(height: 12),
                            _MyWehavitSummaryBullet(
                              iconString: WHIcons.emojiClap,
                              preText: '그리고 ',
                              highlightedText: '${userEntity.cumulativeReactions}번',
                              postText: '이나 친구들을 응원했어요!',
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  error: (_, __) {
                    return Text(
                      '통계 정보를 가져오지 못했어요 😢',
                      style: context.bodyMedium?.copyWith(color: CustomColors.whGrey600),
                    );
                  },
                  loading: () {
                    return LoadingAnimationWidget.waveDots(
                      color: CustomColors.whGrey700,
                      size: 30,
                    );
                  },
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Divider(
              height: 2,
              color: CustomColors.whGrey700,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: CustomColors.whYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              showToastMessage(
                context,
                text: '현재 개발중인 기능입니다!',
              );
            },
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '더 많은 통계 보러가기',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium?.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyWehavitSummaryBullet extends StatelessWidget {
  const _MyWehavitSummaryBullet({
    required this.iconString,
    required this.preText,
    required this.highlightedText,
    required this.postText,
  });

  final String iconString;
  final String preText;
  final String highlightedText;
  final String postText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WHIcon(size: WHIconsize.small, iconString: iconString),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            style: const TextStyle(textBaseline: TextBaseline.ideographic),
            children: [
              TextSpan(
                text: preText,
                style: context.bodyLarge?.copyWith(color: CustomColors.whGrey900),
              ),
              TextSpan(
                text: highlightedText,
                style: context.titleMedium?.copyWith(color: CustomColors.whYellow500),
              ),
              TextSpan(
                text: postText,
                style: context.bodyLarge?.copyWith(color: CustomColors.whGrey900, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
