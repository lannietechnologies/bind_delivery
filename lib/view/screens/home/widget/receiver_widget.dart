import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/cal_chat_widget.dart';

class ReceiverWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final bool fromReviewPage;
  const ReceiverWidget({Key? key, this.orderModel, this.fromReviewPage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: Column(children: [
          (orderModel!.customer != null || orderModel!.isGuest!)?
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(.25),
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(50)),
                child: ClipRRect(borderRadius: BorderRadius.circular(50),
                  child: CustomImage(image: '${Get.find<SplashController>().baseUrls!.customerImageUrl}/${orderModel?.customer?.image}',
                    height: 50, width: 50, fit: BoxFit.cover))),

              Expanded(child: Padding(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0,0,0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text( orderModel!.isGuest! ? orderModel?.shippingAddress?.contactPersonName??'' :'${orderModel!.customer!.fName} ${orderModel!.customer!.lName}',
                        style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),

                      Text('customer'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color:Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).primaryColor.withOpacity(.75))),
                    ],
                  ),
                ),
              ),

              fromReviewPage?
                  Container(padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(.05),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                      child: Icon(Icons.bookmark,color: Theme.of(context).colorScheme.secondary.withOpacity(.125))):
              CallAndChatWidget(orderModel: orderModel),
            ],
          ):const SizedBox(),

        ],
      ),
    );
  }
}
