import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/wallet/widget/deposited_card_widget.dart';

class DepositedListView extends StatelessWidget {
  const DepositedListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
        builder: (walletController) {

          return !walletController.isLoading? walletController.depositedList.isNotEmpty?
          ListView.builder(
              itemCount: walletController.depositedList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index){
                return DepositedCardWidget(deposit: walletController.depositedList[index]);
              }): const NoDataScreen(): CustomLoader(height: Get.height-600,);
        }
    );
  }
}
