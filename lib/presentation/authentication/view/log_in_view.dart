import 'package:flutter/material.dart';
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
      body: Container(),
    );
  }
}
