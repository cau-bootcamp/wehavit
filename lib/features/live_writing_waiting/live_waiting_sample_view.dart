import 'package:flutter/material.dart';
import 'package:wehavit/features/live_writing_waiting/presentation/view/live_waiting_view.dart';

class LiveWaitingSampleView extends StatelessWidget {
  const LiveWaitingSampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: LiveWritingView(),
      ),
    );
  }
}
