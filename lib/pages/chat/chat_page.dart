import 'package:flutter/material.dart';

import '../../controllers/boot_controller.dart';
import '../../models/message_model.dart';
import '../../controllers/chat_controller.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final StringBuffer message = StringBuffer();
  final chatController = ChatController()
    ..addBot(
      BotController()
        ..addCommand('hello', (command) => 'Hello, how are you?')
        ..addCommand('good', (command) => 'That\'s great!')
        ..addCommand('bad', (command) => 'I\'m sorry to hear that.'),
    );

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.rocket_launch),
            SizedBox(width: 8),
            Text('Chat Bot'),
          ],
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: chatController,
              builder: (context, value, child) {
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: List.generate(
                      chatController.messages.length,
                      (index) {
                        final message = chatController.messages[index];
                        if (message.text == "menu") {
                          return Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Wrap(
                                alignment: WrapAlignment.spaceAround,
                                children: List.generate(
                                  5,
                                  (index) => FloatingActionButton(
                                    onPressed: () {
                                      chatController.addMessage(
                                        MessageModel(
                                          sender: Sender.me,
                                          time: DateTime.now(),
                                          text: "menu $index",
                                        ),
                                      );
                                    },
                                    child: Text("menu $index"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: message.isUser ? Colors.lightGreen : Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "${message.time.hour}:${message.time.minute}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).reversed.toList(),
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: textFieldController,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          message.clear();
                          message.write(value);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        textFieldController.clear();

                        chatController.addMessage(
                          MessageModel(
                            text: message.toString(),
                            sender: Sender.me,
                            time: DateTime.now(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.send),
                    ),
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
