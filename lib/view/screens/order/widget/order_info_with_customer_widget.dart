import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/animated_custom_dialog.dart';
import 'package:sixvalley_delivery_boy/view/screens/home/widget/receiver_widget.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/order_action_item_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/order_current_status_change_dialog.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/tracking_stepper_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_tracking/order_tracking_screen.dart';


class OrderInfoWithCustomerWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final bool fromMap;
  const OrderInfoWithCustomerWidget({Key? key, this.orderModel, this.fromMap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom : Dimensions.paddingSizeSmall),
      child: GetBuilder<OrderController>(
        builder: (orderController) {
          return Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
            padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),

            child: Column(children: [
              Padding(padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: Text('${'order'.tr} # ${orderModel!.id}',style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                    color: Theme.of(context).colorScheme.secondary))),
              Divider(height: .75,color: Theme.of(context).primaryColor.withOpacity(.725)),
              Padding(padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: TrackingStepperWidget(status: orderModel!.orderStatus)),
              fromMap? const SizedBox():

              GestureDetector(onTap: () => Get.to(()=> OrderTrackingScreen(orderModel: orderModel)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: Container(decoration: BoxDecoration(
                      color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor.withOpacity(.125),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge)),
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeSmall),
                      child: Text('view_on_map'.tr,style: rubikRegular.copyWith(color: Get.isDarkMode ?Theme.of(context).hintColor : Theme.of(context).colorScheme.secondary))))),

              ReceiverWidget(orderModel: orderModel),

              Row(children:  [
                Expanded(child: OrderActionItem(icon: Images.cancelIcon, title: 'cancel',
                  onTap: () => showAnimatedDialog(context,  OrderStatusUpdateDialog(icon: Images.cancelIcon,
                  title: 'why_you_want_to_cancel_this_delivery'.tr,
                   onYesPressed: (){
                     Get.back();
                     orderController.cancelOrderStatus(
                         orderId: orderModel!.id,
                         cause: orderController.reasonValue!.tr,
                         context: context);
                  },),isFlip: true),)),
                 Expanded(child: OrderActionItem(icon: Images.reachedIcon,title: 'reached',

                  onTap: () => showAnimatedDialog(context,  OrderStatusUpdateDialog(icon: Images.reachedIcon,
                    isReschedule: true,
                    title:  'why_you_want_to_pause_this_delivery'.tr,
                    onYesPressed: (){
                      Get.back();
                      orderController.rescheduleOrderStatus(
                          orderId: orderModel!.id,
                          deliveryDate: orderController.dateFormat.format(orderController.startDate!).toString(),
                          cause: orderController.reasonValue!.tr,
                          context: context);

                    },),isFlip: true),)),
                 Expanded(child: OrderActionItem(icon: !orderModel!.isPause!? Images.pauseIcon : Images.resume,
                   title: !orderModel!.isPause!? 'pause' : 'resume',
                  onTap: () => showAnimatedDialog(context,  OrderStatusUpdateDialog(
                    isResume: orderModel!.isPause!,
                    icon: !orderModel!.isPause!? Images.pauseIcon : Images.resume,
                    title:! orderModel!.isPause!? 'why_you_want_to_pause_this_delivery'.tr  : 'do_you_want_to_resume_the_delivery'.tr,
                    onYesPressed: (){
                      Get.back();
                      orderController.pauseAndResumeOrder(
                          orderId: orderModel!.id,
                          isPos: orderModel!.isPause!?0:1,
                          cause: orderController.reasonValue!.tr,
                          context: context);
                    },),isFlip: true),)),
              ],)

            ],),);
        }
      ),
    );
  }
}
