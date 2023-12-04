import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/features/home/domain/models/confirm_post_model.dart';

class ConfirmPostWidget extends StatefulWidget {
  const ConfirmPostWidget({super.key, required this.model});

  final ConfirmPostModel model;

  @override
  State<ConfirmPostWidget> createState() => _ConfirmPostWidgetState();
}

class _ConfirmPostWidgetState extends State<ConfirmPostWidget> {
  late String userName = widget.model.userName;
  late String? userImageUrl = widget.model.userImageUrl;
  late String resolutionGoalStatement = widget.model.resolutionGoalStatement;
  late String title = widget.model.title;
  late String content = widget.model.content;
  late String? contentImageUrl = widget.model.contentImageUrl;
  late Timestamp postAt = widget.model.postAt;

  bool _initOccurred = false;
  bool _isTextFieldActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.whDarkBlack,
          borderRadius: BorderRadius.circular(20),
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
                        backgroundImage: userImageUrl != null
                            ? NetworkImage(userImageUrl!)
                                as ImageProvider<Object>
                            : const AssetImage('DEBUG_IMAGE'),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
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
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          resolutionGoalStatement,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ), //goal name
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 2,
                width: 345,
                color: CustomColors.whYellow,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 120,
                    width: 180,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      strutStyle: const StrutStyle(fontSize: 16.0),
                      text: TextSpan(
                        text: content,
                      ),
                    ),
                  ),
                  //title
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 3, // 4:3 비율 설정
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: contentImageUrl != null
                                ? NetworkImage(contentImageUrl!)
                                    as ImageProvider<Object>
                                : const AssetImage('DEBUG_IMAGE'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 게시물 하단 격려 남기기 기능들
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (_isTextFieldActive)
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextFormField(
                          controller: _swipeViewModel.textEditingController,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                          cursorColor: CustomColors.whYellow,
                          // 여기에 적절한 커스텀 색상을 사용하세요
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            fillColor: CustomColors.whYellowDark,
                            // 여기에 적절한 커스텀 색상을 사용하세요
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  IconButton(
                    onPressed: () async {
                      if (_isTextFieldActive == true) {
                        await _swipeViewModelProvider.sendTextReaction();
                      }
                      setState(() {
                        _isTextFieldActive =
                            !_isTextFieldActive; // 버튼이 눌릴 때마다 텍스트 필드의 보임/숨김 상태를 토글합니다
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 24,
                    ),
                  ),
                  GestureDetector(
                    onTapUp: (details) async =>
                        emojiSheetWidget(context).whenComplete(() async {
                      _swipeViewModelProvider.sendEmojiReaction();
                    }),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '😄',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    key: _swipeViewModel.cameraButtonPlaceholderKey,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        _swipeViewModel.isCameraInitialized == true
                            ? '📸'
                            : '❌',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
//                  IconButton(
//                    icon: const Icon(
//                      Icons.emoji_emotions,
//                    ),
//                    onPressed: () {
//                      // 기능 연결
//                    },
//                  ),
//                  IconButton(
//                    icon: const Icon(Icons.camera_alt,
//                        color: CustomColors.whYellow),
//                    onPressed: () {
//                      // 기능 연결
//                    },
//                  ),
                ],
              ),
              Divider(color: Colors.grey[700]),
            ],
          ),
        ),
      ),
    );
  }
}
