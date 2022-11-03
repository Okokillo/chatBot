import 'package:chatbot/controllers/chat_controller.dart';

typedef StringCallBack = String Function(String);

class BotController {
  BotController();

  final Map<String, StringCallBack> _commands = {};

  void addCommand(String command, StringCallBack callback) {
    _commands[command] = callback;
  }

  int lengthCommands() {
    return _commands.length;
  }

  String? getCommand(String command) {
    if (_commands.containsKey(command)) {
      return _commands[command]!(command);
    }
    return null;
  }
}
