import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/auth_controller.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/widget/html_view_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/forget_password/forget_password_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/forget_password/widget/code_picker_widget.dart';



class LoginScreen extends StatefulWidget {
   const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;


  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController!.text = Get.find<AuthController>().getUserEmail();
    _passwordController!.text = Get.find<AuthController>().getUserPassword();
    ///Remove for issue no -3
    //_countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.countryCode!).dialCode;
  }


  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Form(key: _formKeyLogin,
          child: GetBuilder<AuthController>(
            builder: (authController){
              return ListView(physics: const BouncingScrollPhysics(), children: [

                   SizedBox(height: Dimensions.topSpace),


                  Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Image.asset(Images.splashLogo,
                      height: 50, fit: BoxFit.scaleDown, matchTextDirection: true,
                    ),
                  ),


                  Center(
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppConstants.appName, style: rubikMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge)),
                              Text(' APP', style: rubikMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge, color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :
                              Theme.of(context).primaryColor)),
                            ],
                          ),
                           SizedBox(height: Dimensions.paddingSizeDefault),
                          Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${'welcome_to'.tr} ${AppConstants.companyName}', style: rubikMedium.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor)),
                              SizedBox(width: 40, child: Image.asset(Images.hand))
                            ],
                          ),
                        ],
                      )),
                   SizedBox(height: Dimensions.loginSpace),

                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Text('login'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor)),
                     SizedBox(height: Dimensions.fontSizeExtraSmall),
                    Text('to_reach_your_customer_destination'.tr,style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                  ],),
                   SizedBox(height: Dimensions.topSpace),



                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                      borderRadius: BorderRadius.circular(Dimensions.topSpace)
                    ),
                    child: Stack(
                      children: [

                        Container(width:61, height: 53,
                            decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(.125),
                            borderRadius: Get.find<LocalizationController>().isLtr? BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.topSpace),
                                bottomLeft: Radius.circular(Dimensions.topSpace)):
                            BorderRadius.only(
                                topRight: Radius.circular(Dimensions.topSpace),
                                bottomRight: Radius.circular(Dimensions.topSpace))
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top : 4.0),
                          child: Row(children: [
                            SizedBox(width: Dimensions.loginColor,
                              child: CodePickerWidget(
                                dialogBackgroundColor:  Theme.of(context).cardColor,
                                onChanged: (countryCode) {
                                  Get.find<AuthController>().updateCountryDialCode(countryCode.dialCode!);
                                },
                                initialSelection: Get.find<AuthController>().countryCode,
                                favorite: [Get.find<AuthController>().countryCode],
                                showDropDownButton: true,
                                padding: EdgeInsets.zero,

                                showFlagMain: true,
                                flagWidth: 25,
                                textStyle: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.displayLarge!.color),

                              ),
                            ),



                            Expanded(child: Container(
                              transform:Get.find<LocalizationController>().isLtr?
                              Matrix4.translationValues(-25, 0, 0): Matrix4.translationValues(25, 0, 0),
                              child: CustomTextField(
                                hintText: '123456789',
                                noPadding: true,
                                nextFocus: _passwordFocus,
                                controller: _emailController,
                                focusNode: _emailFocus,
                                inputType: TextInputType.phone,
                                inputAction: TextInputAction.next,
                              ),
                            )),
                          ]),
                        ),

                      ],
                    ),
                  ),
                   SizedBox(height: Dimensions.paddingSizeLarge),


                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(Dimensions.topSpace)
                    ),
                    child: Stack(
                      children: [
                        Container(width: 59, height: 53, decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(.125),
                            borderRadius:  Get.find<LocalizationController>().isLtr?
                            BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.topSpace),
                                bottomLeft: Radius.circular(Dimensions.topSpace)):
                            BorderRadius.only(
                                topRight: Radius.circular(Dimensions.topSpace),
                                bottomRight: Radius.circular(Dimensions.topSpace))
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top : 4.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom : 4.0),
                                child: SizedBox(width: 59,height: 20, child: Image.asset(Images.lock)),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  hintText: 'password_hint'.tr,
                                  isPassword: true,
                                  isShowSuffixIcon: true,
                                  focusNode: _passwordFocus,
                                  noPadding: true,
                                  controller: _passwordController,
                                  inputAction: TextInputAction.done,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: Dimensions.paddingSizeLarge),


                  Padding(
                    padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: ()  => authController.toggleRememberMe(),
                          child: Row(
                            children: [
                              Container(width: Dimensions.rememberMeSizeDefault, height: Dimensions.rememberMeSizeDefault,
                                decoration: BoxDecoration(color: authController.isActiveRememberMe ?
                                    Theme.of(context).primaryColor : ColorResources.colorWhite,
                                    border: Border.all(color: authController.isActiveRememberMe ?
                                    Colors.transparent : Theme.of(context).highlightColor),
                                    borderRadius: BorderRadius.circular(3)),
                                child: authController.isActiveRememberMe ?
                                 Icon(Icons.done, color: ColorResources.colorWhite,
                                    size: Dimensions.rememberMeSizeDefault) :
                                const SizedBox.shrink(),
                              ),
                               SizedBox(width: Dimensions.paddingSizeSmall),

                              Text('remember_me'.tr, style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).highlightColor),),



                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(const ForgetPasswordScreen());
                          },
                            child: Text('forget_password'.tr,
                          style: rubikRegular.copyWith(color: Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) :Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline),)),
                      ],
                    ),
                  ),
                   SizedBox(height: Dimensions.paddingSizeLarge),



                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [authController.loginErrorMessage.isNotEmpty ?
                     CircleAvatar(backgroundColor: Colors.red, radius: Dimensions.paddingSizeExtraSmall) :
                    const SizedBox.shrink(),
                      SizedBox(width: Dimensions.paddingSizeSmall),



                      Expanded(
                        child: Text(authController.loginErrorMessage,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontSize: Dimensions.fontSizeSmall, color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),



                  const SizedBox(height: 10),
                  !authController.isLoading ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width/3.5),
                    child: CustomButton(
                      btnTxt: 'login'.tr,
                      onTap: () async {
                        String countryCode =  Get.find<AuthController>().countryCode.replaceAll('+', '');
                        String phone = _emailController!.text.trim();
                        String _password = _passwordController!.text.trim();
                        if (phone.isEmpty) {
                          showCustomSnackBar('enter_phone_number'.tr);
                        }else if (_password.isEmpty) {
                          showCustomSnackBar('enter_password'.tr);
                        }else if (_password.length < 6) {
                          showCustomSnackBar('password_should_be'.tr);
                        }else {
                          authController.login(countryCode, phone, _password).then((status) async {
                            if (status.isSuccess) {
                              if (authController.isActiveRememberMe) {
                                authController.saveUserNumberAndPassword(phone, _password);
                              } else {
                                authController.clearUserEmailAndPassword();
                              }
                              await Get.find<ProfileController>().getProfile();
                             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const DashboardScreen(pageIndex: 0,)));
                            }else {
                              showCustomSnackBar(status.message);
                            }
                          });
                        }
                      },
                    ),
                  ) :
                  Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  )),



                  GestureDetector(
                    onTap: (){
                      Get.to(()=> HtmlViewScreen(title: 'terms_and_conditions'.tr,
                        url: Get.find<SplashController>().configModel!.termsConditions));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('terms_and_conditions'.tr,
                            style: rubikRegular.copyWith(color:Get.isDarkMode? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor, decoration: TextDecoration.underline),),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
