enum Sender { me, other }

class MessageModel {
  final Sender sender;
  final DateTime time;
  final String text;

  MessageModel({
    required this.sender,
    required this.time,
    required this.text,
  });

  bool get isUser => sender == Sender.me;
}
