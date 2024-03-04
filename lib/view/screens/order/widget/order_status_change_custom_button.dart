import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/camera_or_gallery.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/slider_button.dart';
import 'package:get/get.dart';

class OrderStatusChangeCustomButton extends StatelessWidget {
  final OrderModel? orderModel;
  final int? index;
  final double? totalPrice;
  const OrderStatusChangeCustomButton({Key? key, this.orderModel, this.index, this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (orderModel!.orderStatus == 'processing' || orderModel!.orderStatus == 'out_for_delivery') && !orderModel!.isPause! ?
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeSmall),
      child: SliderButton(

        action:  ()  {
          if(orderModel!.orderStatus == 'processing'){
            Get.find<OrderController>().updateOrderStatus(orderId: orderModel!.id,
                status: 'out_for_delivery',context: context);
            Get.find<OrderController>().getCurrentOrders();
          }else if(orderModel!.orderStatus == 'out_for_delivery'){

           if(Get.find<SplashController>().configModel?.imageUpload == 1){
              showDialog(context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(backgroundColor: Colors.transparent,

                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        InkWell(onTap: (){
                          Get.find<OrderController>().gotoEndOfPage();
                          Get.back();
                        },
                          child: Padding(padding: EdgeInsets.only(bottom : Dimensions.paddingSizeDefault),
                              child: Icon(Icons.cancel_rounded, color: Theme.of(context).hintColor,size: 30,)),
                        ),
                        InkWell(onTap: (){
                          Get.back();
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: CameraOrGallery(orderModel: orderModel, totalPrice: totalPrice),
                              );
                            },
                          );

                        },
                          child: Container(width: Get.width,height: 170,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                            child: Column(children: [
                              Padding(padding: EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                                child: Text('take_a_picture'.tr, style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),),
                              Container(width: 150,height: 75,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(.125),
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
                                  ),
                                  child: Image.asset(Images.camera))
                            ],),),
                        )
                      ],
                      ),
                    );
                  });
            }else{
             Get.find<OrderController>().gotoEndOfPage();
           }
          }
        },

        label: Text(orderModel!.orderStatus == 'processing'? 'swipe_to_out_for_delivery_order'.tr : 'swip_to_deliver_order'.tr,
          style: rubikMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),),
        dismissThresholds: 0.5,
        icon: const RotationTransition(
          turns:  AlwaysStoppedAnimation(45 / 360),
          child: Center(child: Icon(CupertinoIcons.paperplane,
            color: Colors.white, size: 20.0,
            semanticLabel: 'Text to announce in accessibility modes',)),
        ),

        radius: 100,
        width: MediaQuery.of(context).size.width-55,
        boxShadow: const BoxShadow(blurRadius: 0.0),
        buttonColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.05),
        baseColor: Theme.of(context).primaryColor,
      ),
    ):const SizedBox();}
}
