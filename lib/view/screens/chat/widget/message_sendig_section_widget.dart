import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/chat_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';

class MessageSendingSectionWidget extends StatefulWidget {
  final int? userId;
  const MessageSendingSectionWidget({Key? key, required this.userId}) : super(key: key);

  @override
  State<MessageSendingSectionWidget> createState() => _MessageSendingSectionWidgetState();
}

class _MessageSendingSectionWidgetState extends State<MessageSendingSectionWidget> {
  final TextEditingController _inputMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (chatController) {
        return Padding(
          padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Container(
            padding:  EdgeInsets.only(left : Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeOverLarge),
              boxShadow: [BoxShadow(color: Get.isDarkMode ? Colors.grey[900]! :Colors.grey[300]!, blurRadius: 5, spreadRadius: 1, offset: const Offset(0,2))],
            ),
            child: Row(children: [
              Expanded(
                child: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(Dimensions.messageInputLength)],
                  controller: _inputMessageController,
                  textCapitalization: TextCapitalization.sentences,
                  style: rubikRegular,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(onTap: ()=>  chatController.pickMultipleImage(false),
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: SizedBox(width: 30, child: Image.asset(Images.attachment)),
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'type_here'.tr,
                    hintStyle: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge),
                  ),
                  onSubmitted: (String newText) {
                    if(newText.trim().isNotEmpty && !Get.find<ChatController>().isSendButtonActive) {
                      Get.find<ChatController>().toggleSendButtonActivity();
                    }else if(newText.isEmpty && Get.find<ChatController>().isSendButtonActive) {
                      Get.find<ChatController>().toggleSendButtonActivity();
                    }
                  },
                  onChanged: (String newText) {
                    if(newText.trim().isNotEmpty && !Get.find<ChatController>().isSendButtonActive) {
                      Get.find<ChatController>().toggleSendButtonActivity();
                    }else if(newText.isEmpty && Get.find<ChatController>().isSendButtonActive) {
                      Get.find<ChatController>().toggleSendButtonActivity();
                    }
                  },
                ),
              ),

              GetBuilder<ChatController>(builder: (chatController) {
                return InkWell(
                  onTap: () async {
                    if(chatController.isSendButtonActive || chatController.pickedImageFileStored!.isNotEmpty) {
                      await chatController.sendMessage(
                         _inputMessageController.text, widget.userId!).then((value) {
                        if(value.statusCode == 200){
                          Future.delayed(const Duration(seconds: 2),() {
                            chatController.getMessages(1, widget.userId);
                          });
                        }
                      });
                      _inputMessageController.clear();
                    }else{
                      showCustomSnackBar('write_somethings'.tr);
                    }
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: chatController.isSending ? const SizedBox(
                      width: 25, height: 25,
                      child: CircularProgressIndicator(),
                    ) : Image.asset(
                      Images.send, width: 25, height: 25,
                      color: chatController.isSendButtonActive ?Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor : Theme.of(context).hintColor,
                    ),
                  ),
                );
              }
              ),

            ]),
          ),
        );
      }
    );
  }
}
