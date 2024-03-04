
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/chat_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/screens/chat/widget/message_list_view.dart';
import 'package:sixvalley_delivery_boy/view/screens/chat/widget/message_sendig_section_widget.dart';


class ChatScreen extends StatefulWidget {
  final int? userId;
  final String? name;
  const ChatScreen({Key? key, required this.userId, this.name = 'chat'}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    Get.find<ChatController>().getMessages(1, widget.userId,firstLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (chatController) {
      return Scaffold(
        appBar: CustomRiderAppBar(title: widget.name, isBack: true,),

        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [

              chatController.messageModel != null ?
               Expanded(
                  child: (chatController.messageModel!.message != null && chatController.messageModel!.message!.isNotEmpty) ?
                  MessageListView(chatController: chatController, scrollController: _scrollController, userId: widget.userId) :
                  const SizedBox()): Expanded(child: CustomLoader(height: Get.height-300,)),



              chatController.pickedImageFileStored != null && chatController.pickedImageFileStored!.isNotEmpty ?
              Container(height: 90, width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return  Stack(children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(borderRadius: BorderRadius.circular(10),
                              child: SizedBox(height: 80, width: 80,
                                  child: Image.file(File(chatController.pickedImageFileStored![index].path), fit: BoxFit.cover)))),


                      Positioned(right: 5,
                          child: InkWell(
                              child: const Icon(Icons.cancel_outlined, color: Colors.red),
                              onTap: () => chatController.pickMultipleImage(true,index: index))),
                    ],
                    );},
                  itemCount: chatController.pickedImageFileStored!.length,
                ),
              ) : const SizedBox(),

              Container(
                color: Theme.of(context).canvasColor,
                child: Column(children: [
                   MessageSendingSectionWidget(userId: widget.userId),
                ]),
              ), //: const SizedBox(),
            ]),
          ),
        ),
      );
    }
    );
  }
}
