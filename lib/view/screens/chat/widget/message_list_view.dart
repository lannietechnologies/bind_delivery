import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/chat_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/paginated_list_view.dart';
import 'package:sixvalley_delivery_boy/view/screens/chat/widget/message_bubble.dart';

class MessageListView extends StatelessWidget {
  final ChatController chatController;
  final ScrollController scrollController;
  final int? userId;
  const MessageListView({Key? key, required this.chatController, required this.scrollController, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      reverse: true,
      child: PaginatedListView(
        reverse: true,
        scrollController: scrollController,
        totalSize: chatController.messageModel?.totalSize,
        offset: chatController.messageModel != null ? int.parse(chatController.messageModel!.offset!) : null,
        onPaginate: (int? offset) async {
          await chatController.getMessages(offset!, userId);
        },

        itemView: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemCount: chatController.messageModel!.message!.length,
          itemBuilder: (context, index) {
            return MessageBubble(message: chatController.messageModel!.message![index]);
          },
        ),
      ),
    );
  }
}
