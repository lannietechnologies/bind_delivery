
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';


class CameraOrGallery extends StatefulWidget {
  final OrderModel? orderModel;
  final double? totalPrice;

  const CameraOrGallery({Key? key, this.orderModel, this.totalPrice}) : super(key: key);

  @override
  State<CameraOrGallery> createState() => _CameraOrGalleryState();
}

class _CameraOrGalleryState extends State<CameraOrGallery> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      child: GetBuilder<OrderController>(builder: (orderController) {
        return Padding(
          padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Container(
              height: 5, width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                color: Theme.of(context).disabledColor.withOpacity(0.5),
              ),
            ),


            Padding(padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeOverLarge, top: 50),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(onTap: (){
                      Get.find<OrderController>().gotoEndOfPage();
                      orderController.pickImage(camera: true);
                      Navigator.of(context).pop();
                    },
                        child:  Icon(CupertinoIcons.camera_fill, size: 75, color:Get.isDarkMode ? Theme.of(context).hintColor : Theme.of(context).primaryColor,)),
                  ),
                  Expanded(
                    child: InkWell(onTap: (){
                      Get.find<OrderController>().gotoEndOfPage();
                      orderController.pickImage();
                      Navigator.of(context).pop();
                    },
                        child: Icon(CupertinoIcons.photo_fill,  size: 75, color:Get.isDarkMode ? Theme.of(context).hintColor : Theme.of(context).primaryColor)),
                  ),

                ],
              ),
            )

          ]),
        );
      }),
    );
  }
}
