import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class SignUpAuthDataView extends StatelessWidget {
  const SignUpAuthDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '회원가입',
        leadingTitle: '',
        leadingIcon: Icons.chevron_left,
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이메일',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '이메일',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                    filled: true,
                    fillColor: CustomColors.whGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '비밀번호',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '비밀번호',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                    filled: true,
                    fillColor: CustomColors.whGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    '알파벳과 숫자로 구성된 6~18자리 비밀번호같은 느낌',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: CustomColors.whPlaceholderGrey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '비밀번호 확인',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '비밀번호 확인',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                    filled: true,
                    fillColor: CustomColors.whGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: const Text(
                    '잘했어요!',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: PointColors.green,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            WideColoredButton(
              buttonTitle: "다음",
              backgroundColor: CustomColors.whYellow,
              foregroundColor: CustomColors.whBlack,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpUserDetailView();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpUserDetailView extends StatelessWidget {
  const SignUpUserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: '회원가입',
        leadingTitle: '',
        leadingIcon: Icons.chevron_left,
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        maintainBottomViewPadding: true,
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  File(pickedFile.path);
                }
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -5,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.whWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이름',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '친구들에게 보여지는 이름이예요',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                    filled: true,
                    fillColor: CustomColors.whGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '사용자 ID',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '친구가 나를 찾을 때 사용하는 ID예요',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                    filled: true,
                    fillColor: CustomColors.whGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '한 줄 소개',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whWhite,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 8.0,
                ),
                TextFormField(
                  cursorColor: CustomColors.whWhite,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: CustomColors.whWhite,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: '나에 대해 소개해주세요',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.whPlaceholderGrey,
                    ),
                    filled: true,
                    fillColor: CustomColors.whGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            WideColoredButton(
              buttonTitle: "완료",
              backgroundColor: CustomColors.whYellow,
              foregroundColor: CustomColors.whBlack,
            ),
          ],
        ),
      ),
    );
  }
}
