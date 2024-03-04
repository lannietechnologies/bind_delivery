import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';
import 'package:sixvalley_delivery_boy/view/screens/forget_password/widget/code_picker_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/forget_password/widget/otp_verification_screen.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _numberFocus = FocusNode();
  String? _countryDialCode = '880';

  @override
  void initState() {
    _countryDialCode = CountryCode.fromCountryCode(
        Get.find<SplashController>().configModel!.countryCode!).dialCode;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'forget_password'.tr, isBack: true,),

      body: GetBuilder<ProfileController>(
        builder: (profileController) {
          return Padding(
            padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0, Dimensions.paddingSizeDefault,0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: Text('forget_password'.tr, style: rubikMedium),
                  ),

                  Text('enter_phone_number_for_password_reset'.tr,
                      style: rubikRegular.copyWith(color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeDefault)),



               SizedBox(height: Dimensions.paddingSizeDefault),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(Dimensions.topSpace)
                    ),
                    child: Stack(
                      children: [
                        Container(width: 59, height: 53, decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(.125),
                            borderRadius:Get.find<LocalizationController>().isLtr?
                            BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.topSpace),
                                bottomLeft: Radius.circular(Dimensions.topSpace)):
                            BorderRadius.only(
                                topRight: Radius.circular(Dimensions.topSpace),
                                bottomRight: Radius.circular(Dimensions.topSpace))
                        )),
                        Row(children: [
                          SizedBox(width: Dimensions.loginColor,
                            child: CodePickerWidget(
                              dialogBackgroundColor:  Theme.of(context).cardColor,
                              onChanged: (CountryCode countryCode) {
                                _countryDialCode = countryCode.dialCode;
                              },
                              initialSelection: _countryDialCode,
                              favorite: [_countryDialCode!],
                              showDropDownButton: true,
                              padding: EdgeInsets.zero,
                              showFlagMain: true,
                              textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),

                            ),
                          ),



                          Expanded(child: CustomTextField(
                            hintText: '123456789',
                            controller: _numberController,
                            focusNode: _numberFocus,
                            noPadding: true,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,

                          )),
                        ]),

                      ],
                    ),
                  ),


                   SizedBox(height: Dimensions.paddingSizeLarge),



                  !profileController.isForget?
                  CustomButton(
                    btnTxt: 'send_otp'.tr,
                    onTap: () {
                      String? code;

                        if(_numberController.text.isEmpty) {
                         showCustomSnackBar('phone_number_is_required'.tr);

                        }else{
                          if(_countryDialCode!.contains('+')){
                            code = _countryDialCode!.replaceAll('+', '');
                          }

                          profileController.forgetPassword( code,_numberController.text.trim()).then((value) {
                            if(value.statusCode == 200) {
                              Get.to(VerificationScreen(mobileNumber : _numberController.text.trim(), countryCode: code));
                            }
                          });
                        }
                    },
                  ) :
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: (Get.width/2)-40),
                      child: const SizedBox(width: 40,height: 40,
                        child: CircularProgressIndicator()),
                    ),


            ]),
          );
        }
      ),
    );
  }
}

