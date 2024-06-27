import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/domain/entities/entities.dart';

class UserProfileBar extends StatefulWidget {
  const UserProfileBar({super.key, required this.futureUserEntity});

  final EitherFuture<UserDataEntity> futureUserEntity;

  @override
  State<UserProfileBar> createState() => _UserProfileBarState();
}

class _UserProfileBarState extends State<UserProfileBar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureUserEntity,
      builder: (context, snapshot) {
        List<Widget> content;

        if (snapshot.hasData) {
          content = snapshot.data!.fold(
            (l) => [
              Container(
                margin: const EdgeInsets.only(left: 4.0, right: 16.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.whGrey,
                ),
                width: 60,
                height: 60,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '알 수 없음',
                    style: TextStyle(
                      color: CustomColors.whWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
            (data) => [
              Container(
                margin: const EdgeInsets.only(left: 4.0, right: 16.0),
                child: CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(data.userImageUrl ?? ''),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.userName ?? '',
                    style: const TextStyle(
                      color: CustomColors.whWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          content = [
            Container(
              margin: const EdgeInsets.only(left: 4.0, right: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.whRed,
              ),
              width: 60,
              height: 60,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '알 수 없음',
                  style: TextStyle(
                    color: CustomColors.whWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ];
        } else {
          content = [
            Container(
              margin: const EdgeInsets.only(left: 4.0, right: 16.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.whPlaceholderGrey,
              ),
              width: 60,
              height: 60,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ];
        }

        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: content),
            ],
          ),
        );
      },
    );
  }
}
