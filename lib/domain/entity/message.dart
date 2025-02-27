class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime sentTime;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.sentTime,
  });
}
