import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';

class MyChatBubble extends StatelessWidget {
  const MyChatBubble({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
          color: myChatBubbleColor(context),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(kChatBubblesBorderRadius),
              topLeft: Radius.circular(kChatBubblesBorderRadius),
              topRight: Radius.circular(kChatBubblesBorderRadius))),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.profileImage,
  }) : super(key: key);

  final String message;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (profileImage != null)
          CircleAvatar(
            foregroundImage: NetworkImage(profileImage!),
          ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.7,
          ),
          child: Text(
            message,
          ),
          decoration: BoxDecoration(
              color: chatBubbleColor(context),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(kChatBubblesBorderRadius),
                  topLeft: Radius.circular(kChatBubblesBorderRadius),
                  topRight: Radius.circular(kChatBubblesBorderRadius))),
        )
      ],
    );
  }
}
