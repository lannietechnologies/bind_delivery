import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/base/confirmation_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';
import 'package:sixvalley_delivery_boy/view/base/flutter_custom_switch.dart';

class OnlineOfflineButton extends StatelessWidget {
  final bool showProfileImage;
  const OnlineOfflineButton({Key? key, this.showProfileImage = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return GetBuilder<OrderController>(builder: (orderController) {
        return (profileController.profileModel != null) ?
        FlutterCustomSwitch(
          width: showProfileImage ?  100: 40, height: showProfileImage ? 30 : 20,
          valueFontSize: Dimensions.fontSizeDefault, showOnOff: true,
          activeText: showProfileImage ? 'online'.tr : '' ,
          inactiveText: showProfileImage ? 'offline'.tr : '',
          activeColor:  showProfileImage ? Theme.of(context).colorScheme.outline.withOpacity(.25) : Theme.of(context).primaryColor,
          activeTextColor: Theme.of(context).colorScheme.outline.withOpacity(.75),
          activeToggleBorder: Border.all(color: showProfileImage ? Theme.of(context).colorScheme.outline: Theme.of(context).primaryColor, width: 2),
          toggleSize:  showProfileImage ? 30: 20,
          inactiveToggleBorder: Border.all(color: showProfileImage ? Theme.of(context).hintColor: Theme.of(context).primaryColor, width: 2),
          activeIcon: showProfileImage ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomImage(
              image: '${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<ProfileController>().profileModel!.image}',
              height: 30, width: 30, fit: BoxFit.cover,
            ),
          ): const SizedBox(),
          inactiveIcon: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomImage(
              image: '${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<ProfileController>().profileModel!.image}',
              height: 30, width: 30, fit: BoxFit.cover,
            ),
          ),
          value: profileController.profileModel!.isActive == 1? true : false,
          onToggle: (bool isActive) async {
              Get.dialog(ConfirmationDialog(
                icon: Images.logo,
                description:profileController.profileModel!.isActive == 1?
                'are_you_sure_to_offline'.tr : 'are_you_sure_to_online'.tr,
                onYesPressed: () {
                  if(isActive){
                    profileController.profileStatusChange(context, 1);
                  }else{
                    profileController.profileStatusChange(context, 0);
                  }
                },
              ));


          },
        ) : const SizedBox();
      });
    });
  }
}
