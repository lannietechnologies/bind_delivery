import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

class EarningFilterTypeButton extends StatelessWidget {
  final String text;
  final int index;
  const EarningFilterTypeButton({Key? key, required this.text, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.find<OrderController>().setEarningFilterIndex(index);
      },
      child: GetBuilder<OrderController>(builder: (order) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraSmall),
          child: Container(
            padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: order.orderTypeFilterIndex == index ? Theme.of(context).primaryColor : Theme.of(context).hintColor.withOpacity(.0),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            child: Text(text, style: order.orderTypeFilterIndex == index ? rubikMedium.copyWith(color: order.orderTypeFilterIndex == index
                ? Colors.white : Theme.of(context).textTheme.bodyLarge as Color?):
            rubikRegular.copyWith(color: order.orderTypeFilterIndex == index
                ? Theme.of(context).cardColor :Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor.withOpacity(.75), fontWeight: FontWeight.w500)),
          ),
        );
      },
      ),
    );
  }
}