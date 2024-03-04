
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/chat_controller.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/message_model.dart';
import 'package:sixvalley_delivery_boy/helper/date_converter.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/view/screens/chat/widget/image_diaglog.dart';


class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String basUrl =  Get.find<ChatController>().userTypeIndex == 0?
    Get.find<SplashController>().baseUrls!.shopImageUrl??'':
    Get.find<SplashController>().baseUrls!.customerImageUrl??'';

    String image = Get.find<ChatController>().userTypeIndex == 0?  message.sellerInfo != null ?
    message.sellerInfo!.shops![0].image??'':'' :Get.find<ChatController>().userTypeIndex == 1?
    message.customer?.image?? '': Get.find<SplashController>().configModel!.companyLogo??'';

    String? name = Get.find<ChatController>().userTypeIndex == 0?   message.sellerInfo != null ?
    message.sellerInfo!.shops![0].name :'Shop not found' :Get.find<ChatController>().userTypeIndex == 1?
    '${message.customer?.fName} ${{message.customer?.lName}}' : AppConstants.companyName;


    bool _isReply = message.sentByCustomer! || message.sentBySeller! || message.sentByAdmin!;

    return (_isReply) ? Container(
      margin:  EdgeInsets.symmetric(horizontal: 0.0, vertical: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        Text(name!, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
            color: Get.find<ChatController>().userTypeIndex == 0 && message.sellerInfo == null ?
            Theme.of(context).colorScheme.error :
            Get.find<ChatController>().userTypeIndex == 1 && message.customer == null ?
            Theme.of(context).colorScheme.error : null)),
         SizedBox(height: Dimensions.paddingSizeSmall),

        Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [

          ClipRRect(
            child: CustomImage(
              fit: BoxFit.cover, width: 40, height: 40,
              image: Get.find<ChatController>().userTypeIndex == 3? image : '$basUrl/$image',
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          const SizedBox(width: 10),

          Flexible(
            child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if(message.message != null)  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                        borderRadius:  BorderRadius.only(
                          bottomRight: Radius.circular(Dimensions.paddingSizeSmall),
                          topRight: Radius.circular(Dimensions.paddingSizeSmall),
                          bottomLeft: Radius.circular(Dimensions.paddingSizeSmall),
                        ),
                      ),
                      padding: EdgeInsets.all(message.message != null ? Dimensions.paddingSizeDefault : 0),
                      child: Text(message.message ?? ''),
                    ),
                  ),
                  const SizedBox(height: 8.0),


                ]),
          ),
        ]),
         SizedBox(height: Dimensions.paddingSizeSmall),

        Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(message.createdAt!)),
          style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),
        ),

        if(message.attachment!.isNotEmpty)  SizedBox(height: Dimensions.paddingSizeSmall),
        message.attachment!.isNotEmpty?
        Directionality(textDirection:Get.find<LocalizationController>().isLtr ?  TextDirection.ltr :  TextDirection.rtl,
          child: GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 3,
              mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: message.attachment!.length,
            itemBuilder: (BuildContext context, index) {


              return  InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(
                  imageUrl: '${AppConstants.baseUri}/storage/app/public/chatting/${message.attachment![index]}')),
                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                    child:CustomImage(height: 100, width: 100, fit: BoxFit.cover,
                        image: '${AppConstants.baseUri}/storage/app/public/chatting/${message.attachment![index]}')),);

            },),
        ):
        const SizedBox.shrink(),
      ]),
    )
    : Container(
      padding:  EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeLarge),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [

        Text(Get.find<ProfileController>().profileModel!.fName!+" "+Get.find<ProfileController>().profileModel!.lName!, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
         SizedBox(height: Dimensions.paddingSizeSmall),

        Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [

          Flexible(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [

              (message.message != null && message.message!.isNotEmpty) ? Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.paddingSizeSmall),
                      bottomRight: Radius.circular(Dimensions.paddingSizeSmall),
                      bottomLeft: Radius.circular(Dimensions.paddingSizeSmall),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(message.message != null ? Dimensions.paddingSizeDefault : 0),
                    child: Text(message.message??''),
                  ),
                ),
              ) : const SizedBox(),


            ]),
          ),
           SizedBox(width: Dimensions.paddingSizeSmall),

          ClipRRect(borderRadius: BorderRadius.circular(20.0),
            child: CustomImage(
              fit: BoxFit.cover, width: 40, height: 40,
              image: '${Get.find<SplashController>().baseUrls!.deliverymanImageUrl}/${Get.find<ProfileController>().profileModel!.image}',
            ),
          ),
        ]),

         SizedBox(height: Dimensions.paddingSizeSmall),

        Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(message.createdAt!)),
          style: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),
         SizedBox(height: Dimensions.paddingSizeDefault),
        if(message.attachment!.isNotEmpty)  SizedBox(height: Dimensions.paddingSizeSmall),
        message.attachment!.isNotEmpty?
        Directionality(textDirection:Get.find<LocalizationController>().isLtr ?  TextDirection.rtl :  TextDirection.ltr,
          child: GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 3,
              mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: message.attachment!.length,
            itemBuilder: (BuildContext context, index) {


              return  InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(
                  imageUrl: '${AppConstants.baseUri}/storage/app/public/chatting/${message.attachment![index]}')),
                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                    child:CustomImage(height: 100, width: 100, fit: BoxFit.cover,
                        image: '${AppConstants.baseUri}/storage/app/public/chatting/${message.attachment![index]}')),);

            },),
        ):
        const SizedBox.shrink(),

      ]),
    );
  }
}
