import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (profileController) {
          return ListView(physics: const NeverScrollableScrollPhysics(), children: [

              Padding(padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('phone_no'.tr, style: rubikRegular),

                     SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      prefixIconUrl: Images.phone,
                      isDisable: false,
                      noBg: true,
                      isShowBorder: true,
                      fillColor: Theme.of(context).hintColor.withOpacity(.125),
                      hintText: '+${profileController.profileModel!.countryCode ?? ""}${profileController.profileModel!.phone ?? ""}',

                    ),
                  ],
                ),
              ),

              Text('password'.tr, style: rubikRegular),
               SizedBox(height: Dimensions.paddingSizeSmall),

              CustomTextField(
                controller: profileController.passwordController,
                isShowBorder: true,
                noBg: true,
                hintText: 'password'.tr,
                isShowSuffixIcon: true,
                prefixIconUrl: Images.lock,
                focusNode: profileController.passwordFocus,
                nextFocus: profileController.confirmPasswordFocus,
                inputAction: TextInputAction.next,
                isPassword: true),



              Padding(padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: Text('re_enter_password'.tr, style: rubikRegular)),

              CustomTextField(
                noBg: true,
                hintText: 'confirm_password'.tr,
                isShowSuffixIcon: true,
                prefixIconUrl: Images.lock,
                controller: profileController.confirmPasswordController,
                isShowBorder: true,
                focusNode: profileController.confirmPasswordFocus,
                inputAction: TextInputAction.done,
                isPassword: true,
              ),

               SizedBox(height: Dimensions.paddingSizeDefault,),

            ],
          );
        }
    );
  }
}
