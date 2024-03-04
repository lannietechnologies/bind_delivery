import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/withdraw/widget/withdraw_card_widget.dart';

class WithdrawListView extends StatelessWidget {
  const WithdrawListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
        builder: (walletController) {
          return !walletController.isLoading? walletController.withdrawList.isNotEmpty?
          ListView.builder(
              itemCount: walletController.withdrawList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (withdrawContext, withdrawIndex){
                return WithdrawCardWidget(withdraws: walletController.withdrawList[withdrawIndex]);
              }):const NoDataScreen() :CustomLoader(height: Get.height-600,);
        }
    );
  }
}
