import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/theme_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/order_item_info_widget.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/ordered_product_list_view.dart';

class OrderInfoWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final OrderController? orderController;
  final bool fromDetails;
  const OrderInfoWidget({Key? key, this.orderModel, this.orderController, this.fromDetails = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 100]!,
              blurRadius: 5, spreadRadius: 1,)],
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
        ),
        child: Column(children: [
          Row(children: [
            SizedBox(width: 20, child: Image.asset(Images.orderInfo)),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeDefault),
              child: Text('order_info'.tr,style: rubikMedium.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeLarge)),
            ),
          ],),

          Padding(
            padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
            child: Column(children: [
              OrderItemInfoWidget(title: 'order_id',info: orderModel!.id.toString()),
              OrderItemInfoWidget(title: 'order_placed',info: orderModel!.updatedAt.toString(),isDate: true,),
              OrderItemInfoWidget(title: 'payment',info: orderModel!.paymentMethod),
              InkWell(
                  onTap: ()=> Get.bottomSheet(
                    OrderedItemProductList(orderController: orderController),
                    isScrollControlled: true,
                    clipBehavior: Clip.none,
                    enableDrag: true,
                  ),
                  child: OrderItemInfoWidget(title: 'products',info: orderController!.orderDetails!.length.toString(), isProduct: true,)),
            ],),
          )

        ]));
  }
}
