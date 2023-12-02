import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

class ConfirmPostWidget extends StatefulWidget {
  const ConfirmPostWidget({super.key, required this.model});

  final ConfirmPostModel model;

  @override
  State<ConfirmPostWidget> createState() => _ConfirmPostWidgetState();
}

class _ConfirmPostWidgetState extends State<ConfirmPostWidget> {
  late String userName = widget.model.userName;
  late String userImageUrl = widget.model.userImageUrl;
  late String resolutionGoalStatement = widget.model.resolutionGoalStatement;
  late String title = widget.model.title;
  late String content = widget.model.content;
  late String contentImageUrl = widget.model.contentImageUrl;
  late Timestamp postAt = widget.model.postAt;

  @override
  Widget build(BuildContext context) {
//    print(userName);
//    print(userImageUrl);
//    print(resolutionGoalStatement);
//    print(title);
//    print(content);
//    print(contentImageUrl);
//    print(postAt);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: CustomColors.whDarkBlack,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: CustomColors.whSemiBlack,
                        child: CircleAvatar(
                          radius: 30,
                          foregroundImage: NetworkImage(userImageUrl),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userName,
                        style: const TextStyle(
                          color: CustomColors.whSemiWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ), //icon, name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.whYellowDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          resolutionGoalStatement,
                          style: const TextStyle(
                            color: CustomColors.whWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ), //goal name
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: CustomColors.whSemiWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 150,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        strutStyle: const StrutStyle(fontSize: 16.0),
                        text: TextSpan(
                          text: content,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(contentImageUrl),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {},
                    icon: const Icon(Icons.send),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions,
                    ),
                    onPressed: () {
                      // 기능 연결
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt,
                        color: CustomColors.whYellow),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
