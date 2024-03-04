import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/chat_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/base/paginated_list_view.dart';
import 'package:sixvalley_delivery_boy/view/screens/chat/widget/chat_header.dart';
import 'package:sixvalley_delivery_boy/view/screens/chat/widget/conversation_item_card_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_info_widget.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<ChatController>().getConversationList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomRiderAppBar(title: 'message'.tr),
      body: GetBuilder<ChatController>(builder: (chatController) {

        return Column(children: [

          Container(
            height: 180,decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeOverLarge),
                  bottomRight: Radius.circular(Dimensions.paddingSizeOverLarge))),
            padding:  EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraSmall),
            child:  Column(
              children:  [
                GetBuilder<ProfileController>(
                  builder: (profileController) {
                    return ProfileInfoWidget(profileModel: profileController.profileModel,isChat: true);
                  }
                ),
                const ChatHeader(),
              ],
            )),


           SizedBox(height:  Dimensions.paddingSizeSmall),

          chatController.conversationModel != null ? chatController.conversationModel!.chat!.isNotEmpty ?
          Expanded(
            child:  RefreshIndicator(
              onRefresh: () async {
                chatController.getConversationList(1);
                },
              child: Scrollbar(child: SingleChildScrollView(controller: _scrollController,
                  child: Center(child: SizedBox(width: 1170,
                      child:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: PaginatedListView(
                          reverse: false,
                          scrollController: _scrollController,
                          onPaginate: (int? offset) => chatController.getConversationList(offset!),
                          totalSize: chatController.conversationModel?.totalSize,
                          offset: int.parse(chatController.conversationModel!.offset!),
                          enabledPagination: chatController.conversationModel == null,
                          itemView: ListView.builder(
                            itemCount: chatController.conversationModel?.chat!.length,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return  ConversationItemCardWidget(chat: chatController.conversationModel!.chat![index]);
                            },
                          ),
                        ),
                      ))))),
                ),
          ) :const NoDataScreen(): CustomLoader(height: Get.height-500),
        ]);
      }),
    );
  }
}
