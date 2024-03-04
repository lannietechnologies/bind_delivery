
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/customer_info_widget.dart';

class OngoingOrderHeader extends StatelessWidget {
  final OrderModel? orderModel;
  final int? index;
  final bool isExpanded;
  const OngoingOrderHeader({Key? key, this.orderModel, this.index, this.isExpanded = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(children: [
            Text('${'order'.tr} # ${orderModel!.id}',
              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
          ],
        ),
         SizedBox(height: Dimensions.paddingSizeDefault),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            SizedBox(width: Dimensions.iconSizeDefault,child: Image.asset(Images.sellerIcon)),
             SizedBox(width: Dimensions.paddingSizeSmall),
            Text('seller'.tr,
                style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                    color: Get.isDarkMode? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor))
          ],),

          Row(children: [
            Column(children: [
              Padding(
                padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeExtraSmall),
                child: Container(width: Dimensions.iconSizeSmall,height: Dimensions.iconSizeSmall,color: Theme.of(context).primaryColor),
              ),Padding(
                padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeExtraSmall),
                child: Container(width: Dimensions.iconSizeSmall,height: Dimensions.iconSizeSmall,color: Theme.of(context).primaryColor),
              ),Padding(
                padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeExtraSmall),
                child: Container(width: Dimensions.iconSizeSmall,height: Dimensions.iconSizeSmall,color: Theme.of(context).primaryColor),
              ),

              Padding(
                padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: 2),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.tertiary
                  ),
                  width: Dimensions.iconSizeSmall,
                  height: Dimensions.iconSizeSmall,
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: 2),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.tertiary
                  ),
                  width: Dimensions.iconSizeSmall,
                  height: Dimensions.iconSizeSmall,
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: 2),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.tertiary
                  ),
                  width: Dimensions.iconSizeSmall,
                  height: Dimensions.iconSizeSmall,
                ),
              ),


            ],),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                    SizedBox(width: Dimensions.paddingSizeDefault),
                  Text(orderModel!.sellerIs == 'admin'? AppConstants.companyName: orderModel!.sellerInfo?.shop?.name?.trim()??'Shop not found',
                      style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault))
                ],),


                Row(children: [
                   SizedBox(width:Get.context!.width<=400? 15 : Dimensions.paddingSizeLarge),
                  Expanded(
                    child: Text(orderModel!.sellerInfo?.shop?.address??'',
                        maxLines: 2,
                        style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor)),
                  )
                ],),
              ],),
            ),
          ],),




        ],),
         SizedBox(height: Dimensions.paddingSizeExtraSmall),

        CustomerInfoWidget(orderModel: orderModel),


        isExpanded?const SizedBox():
        Container(
            padding:  EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.25) : Theme.of(context).primaryColor.withOpacity(.04)),
            child: Icon(Icons.keyboard_arrow_down,
              size: Dimensions.iconSizeLarge,color:Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).primaryColor.withOpacity(.75),)),

      ],),
    );
  }
}