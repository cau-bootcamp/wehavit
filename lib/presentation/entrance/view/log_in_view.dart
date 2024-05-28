// ignore: file_names
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wehavit/common/common.dart';
import 'package:wehavit/presentation/common_components/common_components.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whDarkBlack,
      appBar: WehavitAppBar(
        title: 'WeHavit',
        leadingTitle: '',
        leadingIcon: Icons.chevron_left,
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.whWhite,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 16.0,
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
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
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
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const WideColoredButton(
                  buttonTitle: '로그인하기',
                  backgroundColor: CustomColors.whYellow,
                  foregroundColor: CustomColors.whBlack,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '회원가입',
                            style: TextStyle(
                              color: CustomColors.whWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 160),
                child: Column(
                  children: [
                    const Text(
                      '다른 방법으로 로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whWhite,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.whPlaceholderGrey,
                          ),
                          child: Image.asset(
                            CustomIconImage.kakaoLogInLogoIcon,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.whPlaceholderGrey,
                          ),
                          child: Image.asset(
                            CustomIconImage.googleLogInLogoIcon,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.whPlaceholderGrey,
                          ),
                          child: Image.asset(
                            CustomIconImage.appleLogInLogoIcon,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
