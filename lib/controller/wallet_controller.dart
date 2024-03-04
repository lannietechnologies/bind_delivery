import 'dart:async';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/data/api/api_checker.dart';
import 'package:sixvalley_delivery_boy/data/model/response/delivery_wise_earned_model.dart';
import 'package:sixvalley_delivery_boy/data/model/response/deposited_model.dart';
import 'package:sixvalley_delivery_boy/data/model/response/withdraw_model.dart';
import 'package:sixvalley_delivery_boy/data/repository/wallet_repo.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';

class WalletController extends GetxController implements GetxService {
  final WalletRepo walletRepo;
  WalletController({required this.walletRepo});

  List<Orders> _deliveryWiseEarned = [];
  List<Withdraws> _withdrawList = [];
  List<Withdraws> get withdrawList => _withdrawList;
  List<Orders> get deliveryWiseEarned => _deliveryWiseEarned;
  List<Deposit> _depositedList = [];
  List<Deposit> get depositedList => _depositedList;
   bool _isLoading = false;
   bool get isLoading => _isLoading;
  bool _isWithdraw = false;
  bool get isWithdraw => _isWithdraw;


   int _selectedItem = 0;
   int get selectedItem => _selectedItem;
  String _startDate = 'dd-mm-yyyy';
  String get startDate => _startDate;
  String _endDate = 'dd-mm-yyyy';
  String get endDate => _endDate;



   void selectedItemForFilter(int index,{bool fromTop = false}){
     if(fromTop){
       _startDate = 'dd-mm-yyyy';
       _endDate = 'dd-mm-yyyy';
     }

     _selectedItem = index;
     if(selectedItem == 0 ){
       getOrderWiseDeliveryCharge(startDate=="dd-mm-yyyy"? '':startDate, endDate =="dd-mm-yyyy"?'': endDate, 1,'');
     } else if(selectedItem == 1 ){
       getWithdrawList(startDate=="dd-mm-yyyy"? '':startDate, endDate =="dd-mm-yyyy"?'': endDate, 1, 'withdrawn');
     }else if(selectedItem == 2 ){
       getWithdrawList(startDate=="dd-mm-yyyy"? '':startDate, endDate =="dd-mm-yyyy"?'': endDate, 1, 'pending');
     }else if(selectedItem == 3 ){
       getDepositedList(startDate=="dd-mm-yyyy"? '':startDate, endDate =="dd-mm-yyyy"?'': endDate, 1, '');
     }
     update();
   }



  Future getOrderWiseDeliveryCharge(String startDate, String endDate, int offset, String type) async {
    _isLoading = true;
    update();
    Response response = await walletRepo.getDeliveryWiseEarned(startDate: startDate,endDate: endDate, offset: offset, type: type);
    if (response.body != null && response.statusCode == 200) {

      _deliveryWiseEarned = [];
      _deliveryWiseEarned.addAll(DeliveryWiseEarnedModel.fromJson(response.body).orders!);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }


  Future getWithdrawList(String startDate, String endDate, int offset, String type, {bool reload = true}) async {
     if(reload){
       _withdrawList = [];
     }
    _isLoading = true;
    update();
    Response response = await walletRepo.getWithdrawList(startDate: startDate,endDate: endDate, offset: offset,type: type);
    if (response.body != null && response.statusCode == 200) {
      _withdrawList.addAll(WithdrawModel.fromJson(response.body).withdraws!);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }


  Future<void> getDepositedList(String startDate, String endDate, int offset, String type, {bool reload = true}) async {
    if(reload){
      _depositedList = [];
    }
    _isLoading = true;
    update();
    Response response = await walletRepo.getDepositedList(startDate: startDate,endDate: endDate, offset: offset,type: type);
    if (response.body != null && response.statusCode == 200) {
      _depositedList.addAll(DepositedModel.fromJson(response.body).deposit!);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }



  Future<Response> sendWithdrawRequest(String amount, String note) async {
    _isWithdraw = true;
    update();
    Response response = await walletRepo.sendWithdrawRequest(amount: amount,note: note);
    if (response.statusCode == 200) {
      Get.find<ProfileController>().getProfile();
      Get.back();
      String? message;
      message = response.body['message'];
      showCustomSnackBar(message, isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    _isWithdraw = false;
    update();
    return response;
  }




  Future <void> selectDate(String startDate, String endDate) async {
    _startDate = startDate;
    _endDate = endDate;
    update();
  }


}
