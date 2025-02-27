import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/chat_message_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatMessageInput extends ConsumerStatefulWidget {
  final String? chatRoomId;
  final String otherUserId;

  const ChatMessageInput(this.chatRoomId, this.otherUserId, {super.key});

  @override
  ConsumerState<ChatMessageInput> createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends ConsumerState<ChatMessageInput> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          _buildMessageTextField(),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildMessageTextField() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorScheme.of(context).surfaceContainerHigh,
        ),
        child: TextField(
          controller: _textController,
          textInputAction: TextInputAction.send,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: '메시지 보내기',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            filled: true,
            fillColor: ColorScheme.of(context).surfaceContainerHigh,
          ),
          onSubmitted: (_) {
            _handleMessageSubmitted();
          },
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return IconButton(
      constraints: BoxConstraints(maxWidth: 40, maxHeight: 40),
      onPressed: _handleMessageSubmitted,
      icon: Icon(Icons.send),
    );
  }

  void _handleMessageSubmitted() async {
    if (_textController.text.isEmpty) return;

    final userId = 'me';
    final chatRoomId = await ref
        .read(chatMessageProvider(widget.chatRoomId).notifier)
        .sendMessage(userId, widget.otherUserId, _textController.text);
    _textController.clear();

    if (widget.chatRoomId == null) {
      if (mounted) {
        context.pushReplacement('/chatroom', extra: {
          'chatRoomId': chatRoomId,
          'otherUserId': widget.otherUserId,
        });
      }
    }
  }
}
