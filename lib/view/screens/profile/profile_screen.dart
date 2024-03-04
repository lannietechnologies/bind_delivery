
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/auth_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/userinfo_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/animated_custom_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/confirmation_dialog.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/online_offline_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/login_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/earning_statement/earning_statement_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/emergency_contact/emergency_contact_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/help_and_support/help_and_support_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/html/html_viewer_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_delivery_info_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_header_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/review/review_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/setting/setting_screen.dart';


class ProfileScreen extends StatelessWidget {
   const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    UserInfoModel? profile = Get.find<ProfileController>().profileModel;
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'my_profile'.tr),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<ProfileController>(builder: (profileController){

            return Column(children: [

                ProfileHeaderWidget(profileModel: profileController.profileModel),

                Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:  [

                    Expanded(child: ProfileDeliveryInfoItem(icon: Images.totalDelivery, title: 'total_delivery',
                        countNumber: double.parse(profile!.totalDelivery.toString()))),

                    Expanded(child: ProfileDeliveryInfoItem(icon: Images.completedDelivery, title: 'completed_delivery',
                        countNumber: double.parse(profile.completedDelivery.toString()))),

                    Expanded(child: ProfileDeliveryInfoItem(icon: Images.totalEarned, title: 'total_earned',
                      countNumber: profile.totalEarn, isAmount: true,)),
                  ],),
                ),
              SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                Container(
                  padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                  color: Get.isDarkMode ? Theme.of(context).cardColor : null,
                  child: Column(children: [

                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
                      child: Row(children: [
                        SizedBox(width: 20, child: Image.asset(Images.statusIcon, color: Theme.of(context).colorScheme.primary,)),
                         SizedBox(width: Dimensions.paddingSizeDefault),
                        Expanded(child: Text('status'.tr,style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                        const OnlineOfflineButton(showProfileImage: false)

                      ],),
                    ),



                    ProfileButton(icon: Images.earnStatement, title: 'earning_statement'.tr,
                        onTap: () => Get.to(const EarningStatementScreen())),




                    ProfileButton(icon: Images.myReview, title: 'my_reviews'.tr,
                        onTap: () => Get.to(const ReviewScreen())),




                    ProfileButton(icon: Images.emergencyContact, title: 'emergency_contact'.tr,
                        onTap: () => Get.to(const EmergencyContactScreen())),



                    ProfileButton(icon: Images.helpSupport, title: 'help_and_support'.tr,
                        onTap: () => Get.to(const HelpAndSupport())),





                    ProfileButton(icon: Images.settingIcon, title: 'setting'.tr,
                        onTap: () => Get.to(const SettingScreen())),


                    ProfileButton(icon: Images.myReview, title: 'privacy_policy'.tr,
                        onTap: () => Get.to(const HtmlViewerScreen(isPrivacyPolicy: true))),


                    ProfileButton(icon: Images.myReview, title: 'terms_and_condition'.tr,
                        onTap: () => Get.to(const HtmlViewerScreen(isPrivacyPolicy: false))),



                    ProfileButton(icon: Images.logOut, title: 'log_out'.tr,
                        onTap: () => showAnimatedDialog(context,  ConfirmationDialog(icon: Images.logOut,
                          title: 'log_out'.tr,
                          description: 'do_you_want_to_log_out_this_account'.tr, onYesPressed: (){
                            Get.find<AuthController>().clearSharedData().then((condition) {
                              Get.back();
                              Get.offAll(const LoginScreen());
                            });

                          },),isFlip: true)),

                    ],
                  ),
                )
              ],
            );

          },)
        ));
  }

}
