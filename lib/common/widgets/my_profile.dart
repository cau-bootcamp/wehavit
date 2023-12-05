import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({
    super.key,
    required this.currentUser,
  });

  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        color: CustomColors.whBlack,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: CustomColors.whYellow,
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: CircleAvatar(
                      radius: 32,
                      foregroundImage: NetworkImage(
                        currentUser?.photoURL ?? 'DEBUG_URL',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser?.displayName ?? 'DEBUG_NO_NAME',
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentUser?.email ?? 'DEBUG_UserID',
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TODO: 링크로 친구 추가하기 추후에.
          //                  Container(
          //                    alignment: Alignment.centerRight,
          //                    margin: const EdgeInsets.only(right: 8.0),
          //                    child: IconButton(
          //                      icon: const Icon(Icons.link),
          //                      color: Colors.black87,
          //                      onPressed: () {},
          //                    ),
          //                  ),
        ],
      ),
    );
  }
}
