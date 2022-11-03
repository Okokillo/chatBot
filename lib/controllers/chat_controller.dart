import 'package:chatbot/controllers/boot_controller.dart';
import 'package:chatbot/models/message_model.dart';
import 'package:flutter/cupertino.dart';

class ChatController extends ValueNotifier {
  List<BotController> bots = [];
  List<MessageModel> messages = [];

  ChatController() : super(null);

  void addBot(BotController bot) {
    bots.add(bot);
  }

  void addMessage(MessageModel message) {
    messages.add(message);
    notifyListeners();

    for (var bot in bots) {
      final response = bot.getCommand(message.text);
      if (response != null) {
        messages.add(
          MessageModel(
            sender: Sender.other,
            time: DateTime.now(),
            text: response,
          ),
        );
        notifyListeners();
      }
    }
  }
}
