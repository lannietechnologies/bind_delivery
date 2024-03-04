import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/response_model.dart';
import 'package:sixvalley_delivery_boy/data/model/response/userinfo_model.dart';
import 'package:sixvalley_delivery_boy/data/repository/auth_repo.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) ;


  final bool _notification = true;
  XFile? _pickedFile;
  final String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;
  String _countryDialCode = "+1";
  String get countryCode => _countryDialCode;


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get notification => _notification;
  XFile? get pickedFile => _pickedFile;

  File? file;
  final picker = ImagePicker();

  int _selectionTabIndex = 1;
  int get selectionTabIndex =>_selectionTabIndex;

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;



  void updateCountryDialCode (String value){
    _countryDialCode = value;
    update();
  }


  void choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedFile != null) {
      file = File(pickedFile.path);
    }
    update();
  }

  void setIndexForTabBar(int index, {bool isNotify = true}){
    _selectionTabIndex = index;
    if(isNotify){
      update();
    }

  }


  Future<ResponseModel> login(String countryCode, String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(countryCode ,phone, password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);

      await authRepo.updateToken();
      responseModel = ResponseModel(true, 'successful');
      setCurrentLanguage(Get.find<LocalizationController>().getCurrentLanguage() ?? 'en');
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }



  Future<void> setCurrentLanguage(String currentLanguage) async {
    Response apiResponse = await authRepo.setLanguageCode(currentLanguage);
    if ( apiResponse.statusCode == 200) {

    }
  }



  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }




  Future<ResponseModel> updateUserInfo(UserInfoModel updateUserModel, String pass) async {
    _isLoading = true;
    update();

    ResponseModel responseModel;

    http.StreamedResponse response = await authRepo.updateProfile(updateUserModel, pass, file, Get.find<AuthController>().getUserToken());
    _isLoading = false;
    if (response.statusCode == 200) {
      Get.find<ProfileController>().getProfile();
      Map map = jsonDecode(await response.stream.bytesToString());
      String? message = map["message"];
      _userInfoModel = updateUserModel;
      responseModel = ResponseModel(true, message);
      showCustomSnackBar(message, isError: false);
    } else {

      responseModel = ResponseModel(false, '${response.statusCode} ${response.reasonPhrase}');
    }
    update();
    return responseModel;
  }



  Future<void> updateToken() async {
    await authRepo.updateToken();
  }


  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }


  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }


  String getUserEmail() {
    return authRepo.getUserEmail();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }


  String getUserToken() {
    return authRepo.getUserToken();
  }


  void initData() {
    _pickedFile = null;
  }

}