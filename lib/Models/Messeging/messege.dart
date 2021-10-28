import 'chat_user_model.dart';

class MessageModel {
  final ChatUserModel user;
  final String message;

  MessageModel(this.user, this.message);

  static List<MessageModel> getMesseges() {
    final ChatUserModel dummyUser = ChatUserModel(
        id: '2',
        profileImage:
            'https://i.pinimg.com/236x/7f/7c/35/7f7c35749870fd4be3eadb4e7c681c69.jpg');

    final ChatUserModel dummyMe = ChatUserModel(
      id: '1',
    );

    final List<MessageModel> allChats = [
      MessageModel(dummyMe, 'I’m running late'),
      MessageModel(dummyUser, 'No Problem!'),
      MessageModel(dummyUser, 'What’s your ETA?'),
    ];
    
    return allChats.reversed.toList();
  }
}
