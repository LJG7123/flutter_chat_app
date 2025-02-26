class Chat {
  final String id;
  final List<String> participants;
  final int unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final String? lastMessageSender;

  Chat({
    required this.id,
    required this.participants,
    required this.unreadCount,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageSender,
  });
}
