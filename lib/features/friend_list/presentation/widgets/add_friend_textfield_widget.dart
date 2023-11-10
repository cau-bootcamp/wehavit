import 'package:flutter/material.dart';

class AddFriendTextFieldWidget extends StatefulWidget {
  @override
  State<AddFriendTextFieldWidget> createState() =>
      _AddFriendTextFieldWidget();
}

class _AddFriendTextFieldWidget extends State<AddFriendTextFieldWidget> {
  final _textController = TextEditingController();

  void _sendText() {
    print('Text to send: ${_textController.text}');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree to avoid memory leaks.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 300,
            margin: EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter Friend ID',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _sendText,
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
