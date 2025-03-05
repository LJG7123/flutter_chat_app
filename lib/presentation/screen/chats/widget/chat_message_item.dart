import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/date_time_util.dart';
import 'package:flutter_chat_app/domain/entity/message.dart';
import 'package:flutter_chat_app/domain/entity/user.dart';
import 'package:flutter_chat_app/presentation/widget/profile_image_widget.dart';

class ChatMessageItem extends StatelessWidget {
  final Message message;
  final Future<User?> future;
  final bool showDateDivider;
  final bool showTimestamp;
  final bool isMine;

  const ChatMessageItem({
    super.key,
    required this.message,
    required this.future,
    required this.showDateDivider,
    required this.showTimestamp,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDateDivider) _buildDateDivider(context),
        _buildMessageItem(context),
      ],
    );
  }

  Widget _buildDateDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        message.sentTime.toDateString(),
        style: TextStyle(
          color: ColorScheme.of(context).onSurfaceVariant,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: showTimestamp ? 8 : 4),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMine) ...[
            _buildSenderAvatar(),
            SizedBox(width: 8),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isMine && showTimestamp) ...[
                _buildTimestamp(context),
                SizedBox(width: 4),
              ],
              _buildMessageBubble(context),
              if (!isMine && showTimestamp) ...[
                SizedBox(width: 4),
                _buildTimestamp(context),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSenderAvatar() {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) => ProfileImageWidget(
        imageUrl: snapshot.data?.imageUrl,
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final messageMaxWidth = MediaQuery.of(context).size.width * 0.6;
    final messageMaxHeight = MediaQuery.of(context).size.height * 0.4;

    return Container(
      padding: EdgeInsets.all(12),
      constraints: BoxConstraints(
        maxWidth: messageMaxWidth,
        maxHeight: messageMaxHeight,
      ),
      decoration: BoxDecoration(
        color:
            isMine ? colorScheme.primary : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: _buildMessageContent(context),
    );
  }

  Widget _buildTimestamp(BuildContext context) {
    return Text(
      message.sentTime.toTimeString(),
      style: TextStyle(
        fontSize: 12,
        color: ColorScheme.of(context).onSurfaceVariant,
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    return Text(
      message.content,
      style: TextStyle(
        color: isMine ? Colors.white : Colors.black,
        fontSize: 16,
      ),
    );
  }
}
