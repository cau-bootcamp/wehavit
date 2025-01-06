import 'package:flutter/material.dart';
import 'package:wehavit/common/common.dart';

enum SNSAuthType {
  google,
  apple,
  kakao,
  none;
}

class SNSLoginButton extends StatelessWidget {
  const SNSLoginButton({
    required this.onPressed,
    required this.snsAuthType,
    super.key,
  });

  final VoidCallback onPressed;
  final SNSAuthType snsAuthType;

  @override
  Widget build(BuildContext context) {
    final imageAsset = switch (snsAuthType) {
      SNSAuthType.google => CustomIconImage.googleLogInLogoIcon,
      SNSAuthType.apple => CustomIconImage.appleLogInLogoIcon,
      SNSAuthType.kakao => CustomIconImage.kakaoLogInLogoIcon,
      SNSAuthType.none => CustomIconImage.iconNone,
    };

    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.whPlaceholderGrey,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
        ),
        onPressed: onPressed,
        child: Image.asset(imageAsset),
      ),
    );
  }
}
