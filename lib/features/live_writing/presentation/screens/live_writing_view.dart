import 'package:flutter/material.dart';

class LiveWritingView extends StatelessWidget {
  const LiveWritingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Stack(children: [Text("hello world!")]),
      ),
    );
  }
}
