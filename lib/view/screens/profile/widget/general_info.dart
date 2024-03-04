import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_image.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {


        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [

            Padding(
              padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('first_name'.tr, style: rubikRegular),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.profileIcon,
                    isShowBorder: true,
                    noBg: true,
                    inputType: TextInputType.name,
                    focusNode: profileController.fNameFocus,
                    nextFocus: profileController.lNameFocus,
                    hintText: profileController.profileModel!.fName ?? '',
                    controller: profileController.firstNameController,
                  ),

                   SizedBox(height: Dimensions.paddingSizeDefault),
                  Text('last_name'.tr, style: rubikRegular),

                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.profileIcon,
                    noBg: true,
                    isShowBorder: true,
                    inputType: TextInputType.name,
                    focusNode: profileController.lNameFocus,
                    nextFocus: profileController.addressFocus,
                    hintText: profileController.profileModel!.lName,
                    controller: profileController.lastNameController,
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  Row(
                    children: [
                      Text('email'.tr, style: rubikRegular),
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                        child: Text('(${'not_editable'.tr})', style: rubikRegular.copyWith(fontSize: Dimensions.paddingSizeSmall,
                            color: Theme.of(context).hintColor.withOpacity(.75))),
                      ),
                    ],
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.emailIcon,
                    noBg: true,
                    fillColor: Theme.of(context).hintColor.withOpacity(.125),
                    isShowBorder: true,
                    isDisable: false,
                    inputType: TextInputType.name,
                    focusNode: profileController.addressFocus,
                    hintText: profileController.profileModel!.email,
                    controller: profileController.emailController ,
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),

                  Row(
                    children: [
                      Text('phone_no'.tr, style: rubikRegular),
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                        child: Text('(${'not_editable'.tr})', style: rubikRegular.copyWith(fontSize: Dimensions.paddingSizeSmall,
                            color: Theme.of(context).hintColor.withOpacity(.75))),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    fillColor: Theme.of(context).hintColor.withOpacity(.125),
                    prefixIconUrl: Images.phoneIcon,
                    noBg: true,
                    isDisable: false,
                    isShowBorder: true,
                    inputType: TextInputType.number,
                    hintText: '+${profileController.profileModel!.countryCode ?? ""} ${profileController.profileModel!.phone ?? ""}',
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),


                  Text('address_s'.tr, style: rubikRegular),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    prefixIconUrl: Images.addressIcon,
                    noBg: true,
                    isShowBorder: true,
                    inputType: TextInputType.name,
                    focusNode: profileController.addressFocus,
                    hintText: profileController.profileModel!.address,
                    controller: profileController.addressController,
                  ),
                ],
              ),
            ),





            Padding(
              padding:  EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('identity_number_and_card'.tr, style: rubikRegular),

                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                        child: Text('(${'not_editable'.tr})', style: rubikRegular.copyWith(fontSize: Dimensions.paddingSizeSmall,
                            color: Theme.of(context).hintColor.withOpacity(.75))),
                      ),
                    ],
                  ),
                   SizedBox(height: Dimensions.paddingSizeSmall),
                  CustomTextField(
                    fillColor: Theme.of(context).hintColor.withOpacity(.125),
                    isDisable: false,
                    prefixIconUrl: Images.identityImage,
                    noBg: true,
                    isShowBorder: true,
                    inputType: TextInputType.number,
                    hintText: '${profileController.profileModel!.identityNumber} (${profileController.profileModel!.identityType})',
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: Row(children: [
                      Expanded(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
                        child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                          child: CustomImage(image: '${Get.find<SplashController>().baseUrls!.deliverymanImageUrl}/${profileController.profileModel!.identityImage![0]}' , height: 120)),)),
                      SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      profileController.profileModel!.identityImage!.length>1?
                      Expanded(child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),
                        child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                          child: CustomImage(image: '${Get.find<SplashController>().baseUrls!.deliverymanImageUrl}/${profileController.profileModel!.identityImage![1]}' , height: 120)),)):const SizedBox(),

                    ],),
                  )
                ],
              ),
            ),

          ],
        );
      }
    );
  }
}
